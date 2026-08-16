#!/usr/bin/env bash
set -euo pipefail

# build_android_wrap.sh — "wrapper"/shell Android build (套包构建).
#
# Instead of compiling the LÖVE Android app from source (see build_android.sh),
# this script starts from the official LÖVE 11.5a "embed" APK from love2d.org,
# swaps in our release .love as assets/game.love, re-aligns and re-signs it.
# It only needs bash, curl, unzip, git, tar and a JDK (8+; 17 recommended) —
# the Android build-tools (zipalign + apksigner) are downloaded automatically.
#
# Known limitations (by design):
#   - The package id stays org.love2d.android (official LÖVE), so the user must
#     uninstall any existing official LÖVE app before installing this APK.
#   - App name/icon/orientation/applicationId/version cannot be customized and
#     the result cannot be published on Google Play (AAB required).
#   - No native code changes; the shell only carries assets/game.love.

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# Scripts live in tools/; the mod root is one level up.
HOMETOWN_MOD_I18N_MOD_DIR="${HOMETOWN_MOD_I18N_MOD_DIR:-$(CDPATH= cd -- "$(dirname -- "$SCRIPT_DIR")" && pwd -P)}"
HOMETOWN_MOD_I18N_MOD_DIR="$(CDPATH= cd -- "$HOMETOWN_MOD_I18N_MOD_DIR" && pwd -P)"
HOMETOWN_MOD_I18N_OUTPUT_DIR="${HOMETOWN_MOD_I18N_OUTPUT_DIR:-$HOMETOWN_MOD_I18N_MOD_DIR/dist}"
HOMETOWN_MOD_I18N_CACHE_DIR="${HOMETOWN_MOD_I18N_CACHE_DIR:-$HOMETOWN_MOD_I18N_MOD_DIR/.build/cache}"
HOMETOWN_MOD_I18N_ANDROID_WORK_DIR="${HOMETOWN_MOD_I18N_ANDROID_WORK_DIR:-$HOMETOWN_MOD_I18N_MOD_DIR/.build/android-wrap}"
HOMETOWN_MOD_I18N_OUTPUT_BASENAME="${HOMETOWN_MOD_I18N_OUTPUT_BASENAME:-hometown-mod-i18n}"

# Official LÖVE 11.5a embed APK (universal: arm64-v8a + armeabi-v7a).
HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_URL="${HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_URL:-https://github.com/love2d/love-android/releases/download/11.5a/love-11.5-android-embed.apk}"
HOMETOWN_MOD_I18N_ANDROID_EMBED_APK="${HOMETOWN_MOD_I18N_ANDROID_EMBED_APK:-}"
HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_SHA256="${HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_SHA256:-dcf71c1b54c5b5a09598ef1e6cf4852ced5e5e612de3d0f30cfdd39b5014e889}"
HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_VERSION="${HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_VERSION:-34.0.0}"
HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_DIR="${HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_DIR:-}"

# Kristal is always fetched non-interactively (tag v0.10.0 by default), so the
# one-click Windows launcher never sees the interactive source prompt.
HOMETOWN_MOD_I18N_KRISTAL_SOURCE="${HOMETOWN_MOD_I18N_KRISTAL_SOURCE:-tag}"
HOMETOWN_MOD_I18N_KRISTAL_REF="${HOMETOWN_MOD_I18N_KRISTAL_REF:-v0.10.0}"

log() {
    printf '[android-wrap] %s\n' "$*" >&2
}

fail() {
    printf '[错误] %s\n' "$*" >&2
    exit 1
}

need_cmd() {
    command -v "$1" >/dev/null 2>&1 || fail "Missing required command: $1"
}

is_windows_host() {
    case "$(uname -s)" in
        MINGW*|MSYS*|CYGWIN*) return 0 ;;
        *) return 1 ;;
    esac
}

# shellcheck source=build-helper/lib.sh
source "$HOMETOWN_MOD_I18N_MOD_DIR/build-helper/lib.sh"

# --- Java -------------------------------------------------------------------
resolve_java() {
    # The wrapper accepts any JDK (8+): an explicit
    # HOMETOWN_MOD_I18N_ANDROID_JAVA_HOME/JAVA_HOME or PATH java is used as-is,
    # and a portable JDK 17 is downloaded into $HOMETOWN_MOD_I18N_TOOLS_DIR/jdk17
    # (the shared tools dir outside the mod tree) only when the box has none.
    ensure_java
    need_cmd keytool
    log "使用 Java: $(command -v java)"
}

# --- Official embed APK ------------------------------------------------------
ensure_embed_apk() {
    local apk="$HOMETOWN_MOD_I18N_ANDROID_EMBED_APK"
    if [ -n "$apk" ]; then
        [ -f "$apk" ] || fail "Embed APK does not exist: $apk"
        printf '%s\n' "$apk"
        return 0
    fi
    mkdir -p "$HOMETOWN_MOD_I18N_CACHE_DIR"
    apk="$HOMETOWN_MOD_I18N_CACHE_DIR/$(basename "$HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_URL")"
    if [ ! -f "$apk" ]; then
        log "下载官方 LÖVE embed APK（约 7 MB）…"
        curl --fail --location --output "$apk" "$HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_URL"
    fi
    if [ -n "$HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_SHA256" ]; then
        actual="$(sha256sum "$apk" | awk '{print $1}')"
        [ "$actual" = "$HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_SHA256" ] || fail \
            "Embed APK checksum mismatch: expected $HOMETOWN_MOD_I18N_ANDROID_EMBED_APK_SHA256, got $actual"
    fi
    printf '%s\n' "$apk"
}

# --- Android build-tools (zipalign + apksigner) ------------------------------
resolve_build_tools_dir() {
    local dir
    if [ -n "$HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_DIR" ]; then
        dir="$HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_DIR"
        if [ -f "$dir/zipalign" ] || [ -f "$dir/zipalign.exe" ]; then
            printf '%s\n' "$dir"
            return 0
        fi
        fail "HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_DIR has no zipalign: $dir"
    fi
    if [ -n "${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}" ]; then
        dir="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}/build-tools/$HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_VERSION"
        if [ -f "$dir/zipalign" ] || [ -f "$dir/zipalign.exe" ]; then
            printf '%s\n' "$dir"
            return 0
        fi
    fi

    # Auto-download into .build/android-wrap/build-tools/<version>.
    local os major zip dest extract
    case "$(uname -s)" in
        Linux*) os=linux ;;
        Darwin*) os=macosx ;;
        MINGW*|MSYS*|CYGWIN*) os=windows ;;
        *) fail "Unsupported OS for auto-downloaded build-tools: $(uname -s)" ;;
    esac
    major="${HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_VERSION%%.*}"
    zip="$HOMETOWN_MOD_I18N_CACHE_DIR/build-tools_r${major}-${os}.zip"
    dest="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/build-tools/$HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_VERSION"
    if [ ! -f "$zip" ]; then
        log "下载 Android build-tools ${HOMETOWN_MOD_I18N_ANDROID_BUILD_TOOLS_VERSION}（约 60 MB）…"
        curl --fail --location --output "$zip" \
            "https://dl.google.com/android/repository/build-tools_r${major}-${os}.zip"
    fi
    if [ ! -d "$dest" ]; then
        extract="$dest.extract"
        rm -rf "$extract"
        mkdir -p "$extract"
        unzip -q "$zip" -d "$extract"
        # The zip historically extracts to a single android-<api> directory.
        dir="$(find "$extract" -maxdepth 2 -type f \( -name zipalign -o -name zipalign.exe \) -printf '%h\n' | head -n 1)"
        [ -n "$dir" ] || fail "Could not find zipalign inside $zip"
        mkdir -p "$(dirname "$dest")"
        mv "$dir" "$dest"
        rm -rf "$extract"
    fi
    printf '%s\n' "$dest"
}

# --- release .love ------------------------------------------------------------
build_love_archive() {
    local love_output="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/love"
    rm -rf "$love_output"
    mkdir -p "$love_output"
    HOMETOWN_MOD_I18N_MOD_DIR="$HOMETOWN_MOD_I18N_MOD_DIR" \
        HOMETOWN_MOD_I18N_ANDROID_TOUCH_SKIP_INTRO=1 \
        HOMETOWN_MOD_I18N_BUILD_VARIANTS=release \
        HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE=0 \
        HOMETOWN_MOD_I18N_OUTPUT_DIR="$love_output" \
        HOMETOWN_MOD_I18N_KRISTAL_SOURCE="$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" \
        HOMETOWN_MOD_I18N_KRISTAL_REF="$HOMETOWN_MOD_I18N_KRISTAL_REF" \
        HOMETOWN_MOD_I18N_NO_OPEN_DIR=1 \
        "$HOMETOWN_MOD_I18N_MOD_DIR/tools/build_standalone.sh"
    [ -s "$love_output/${HOMETOWN_MOD_I18N_OUTPUT_BASENAME}-release.love" ] || fail \
        "The release .love archive was not created"
    printf '%s\n' "$love_output/${HOMETOWN_MOD_I18N_OUTPUT_BASENAME}-release.love"
}

# --- swap assets/game.love ----------------------------------------------------
replace_game_love() {
    local apk="$1" love="$2" work_dir ps1

    work_dir="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/swap"
    rm -rf "$work_dir"
    mkdir -p "$work_dir/assets"

    if command -v zip >/dev/null 2>&1; then
        cp "$love" "$work_dir/assets/game.love"
        (cd "$work_dir" && zip -q -r "$apk" assets)
        return 0
    fi

    if is_windows_host; then
        # Git Bash has no `zip`; use .NET's ZipArchive in Update mode. Existing
        # entries (resources.arsc, lib/*.so) are copied byte-for-byte and the
        # new game.love is written DEFLATE, so nothing needs manual alignment.
        ps1="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/replace_game_love.ps1"
        cat > "$ps1" <<'PS_EOF'
param(
    [Parameter(Mandatory = $true)][string]$Apk,
    [Parameter(Mandatory = $true)][string]$Love
)
# Windows PowerShell 5.1 needs BOTH assemblies loaded: ZipFile lives in
# System.IO.Compression.FileSystem, but ZipArchiveMode (used in the Open call)
# lives in System.IO.Compression. Without the second Add-Type the type lookup
# fails, $zip is null and the game.love swap silently does nothing.
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.IO.Compression
$zip = [System.IO.Compression.ZipFile]::Open($Apk, [System.IO.Compression.ZipArchiveMode]::Update)
try {
    $entry = $zip.GetEntry('assets/game.love')
    if ($entry) { $entry.Delete() }
    $entry = $zip.CreateEntry('assets/game.love', [System.IO.Compression.CompressionLevel]::Optimal)
    $stream = $entry.Open()
    try {
        $in = [System.IO.File]::OpenRead($Love)
        try { $in.CopyTo($stream) } finally { $in.Dispose() }
    } finally { $stream.Dispose() }
} finally { $zip.Dispose() }
PS_EOF
        log "用 PowerShell 替换 assets/game.love（Git Bash 无 zip）…"
        powershell -NoProfile -ExecutionPolicy Bypass \
            -File "$(cygpath -w "$ps1")" \
            -Apk "$(cygpath -w "$apk")" \
            -Love "$(cygpath -w "$love")"
        return 0
    fi

    # No `zip` on Linux/macOS either — fall back to the JDK's jar tool (the JDK
    # is already resolved/bootstrapped by resolve_java, so this adds no new
    # dependency). zipalign + apksigner below re-align and re-sign regardless.
    if command -v jar >/dev/null 2>&1; then
        cp "$love" "$work_dir/assets/game.love"
        log "用 JDK jar 替换 assets/game.love（无 zip）…"
        (cd "$work_dir" && jar -uf "$apk" assets)
        return 0
    fi

    fail "Neither 'zip' nor a JDK jar tool is available to update the APK"
}

# --- signing -------------------------------------------------------------------
resolve_keystore() {
    if [ -n "${HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE:-}" ]; then
        [ -f "$HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE" ] || fail \
            "Android signing keystore does not exist: $HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE"
        [ -n "${HOMETOWN_MOD_I18N_ANDROID_SIGNING_STORE_PASSWORD:-}" ] || fail \
            "HOMETOWN_MOD_I18N_ANDROID_SIGNING_STORE_PASSWORD is required with a custom Android keystore"
        [ -n "${HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_ALIAS:-}" ] || fail \
            "HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_ALIAS is required with a custom Android keystore"
        [ -n "${HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_PASSWORD:-}" ] || fail \
            "HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_PASSWORD is required with a custom Android keystore"
        HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE="$(CDPATH= cd -- "$(dirname -- "$HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE")" && pwd -P)/$(basename -- "$HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE")"
        return 0
    fi

    local keystore="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/debug.keystore"
    if [ ! -f "$keystore" ]; then
        log "生成调试签名密钥库（.build/android-wrap/debug.keystore）…"
        keytool -genkeypair \
            -keystore "$keystore" \
            -alias androiddebugkey \
            -storepass android \
            -keypass android \
            -dname "CN=Android Debug,O=Android,C=US" \
            -keyalg RSA -keysize 2048 -validity 10000
    fi
    HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE="$keystore"
    HOMETOWN_MOD_I18N_ANDROID_SIGNING_STORE_PASSWORD=android
    HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_ALIAS=androiddebugkey
    HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_PASSWORD=android
}

# --- main ----------------------------------------------------------------------
main() {
    local embed_apk love_apk bt_dir zipalign apk_unsigned apk_aligned apk_output apksigner_jar

    need_git
    need_cmd curl
    need_cmd unzip
    need_cmd tar
    need_cmd sha256sum
    resolve_java

    embed_apk="$(ensure_embed_apk)"
    love_apk="$(build_love_archive)"
    bt_dir="$(resolve_build_tools_dir)"
    zipalign="$bt_dir/zipalign"
    [ -x "$zipalign" ] || zipalign="$bt_dir/zipalign.exe"
    [ -f "$zipalign" ] || fail "zipalign not found under $bt_dir"
    apksigner_jar="$bt_dir/lib/apksigner.jar"
    [ -f "$apksigner_jar" ] || fail "apksigner.jar not found under $bt_dir"

    mkdir -p "$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR" "$HOMETOWN_MOD_I18N_OUTPUT_DIR"
    apk_unsigned="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/unsigned.apk"
    apk_aligned="$HOMETOWN_MOD_I18N_ANDROID_WORK_DIR/aligned.apk"
    cp "$embed_apk" "$apk_unsigned"

    log "替换 assets/game.love 为 release .love …"
    replace_game_love "$apk_unsigned" "$love_apk"

    log "zipalign -f 4 …"
    "$zipalign" -f 4 "$apk_unsigned" "$apk_aligned"

    resolve_keystore
    apk_output="$HOMETOWN_MOD_I18N_OUTPUT_DIR/${HOMETOWN_MOD_I18N_OUTPUT_BASENAME}-android-wrap.apk"
    log "apksigner 签名…"
    java -jar "$apksigner_jar" sign \
        --ks "$HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEYSTORE" \
        --ks-pass "pass:$HOMETOWN_MOD_I18N_ANDROID_SIGNING_STORE_PASSWORD" \
        --key-pass "pass:$HOMETOWN_MOD_I18N_ANDROID_SIGNING_KEY_PASSWORD" \
        --v4-signing-enabled false \
        --out "$apk_output" \
        "$apk_aligned"
    test -s "$apk_output"

    java -jar "$apksigner_jar" verify "$apk_output" >/dev/null 2>&1 || fail \
        "Generated APK failed Android signature verification: $apk_output"

    log "Created Android wrapper APK: $apk_output"
    log "提示：包 id 仍为 org.love2d.android，安装前请先卸载官方 LÖVE；"
    log "      此套包不能上架 Google Play（需要 AAB），也不能改图标/名称/applicationId。"
    open_output_dir "$HOMETOWN_MOD_I18N_OUTPUT_DIR"
}

main "$@"
