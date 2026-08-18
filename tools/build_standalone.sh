#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# Scripts live in tools/; the mod root is one level up.
HOMETOWN_MOD_I18N_MOD_DIR="${HOMETOWN_MOD_I18N_MOD_DIR:-$(CDPATH= cd -- "$(dirname -- "$SCRIPT_DIR")" && pwd -P)}"
HOMETOWN_MOD_I18N_MOD_DIR="$(CDPATH= cd -- "$HOMETOWN_MOD_I18N_MOD_DIR" && pwd -P)"
HOMETOWN_MOD_I18N_BUILD_ROOT="${HOMETOWN_MOD_I18N_BUILD_ROOT:-$HOMETOWN_MOD_I18N_MOD_DIR/.build/standalone}"
HOMETOWN_MOD_I18N_OUTPUT_DIR="${HOMETOWN_MOD_I18N_OUTPUT_DIR:-$HOMETOWN_MOD_I18N_MOD_DIR/dist}"
HOMETOWN_MOD_I18N_CACHE_DIR="${HOMETOWN_MOD_I18N_CACHE_DIR:-$HOMETOWN_MOD_I18N_MOD_DIR/.build/cache}"

# Remember what the user actually set before we fill in defaults. This keeps
# an explicit KRISTAL_ROOT/HOMETOWN_MOD_I18N_KRISTAL_DIR as a deliberate local
# source while an unconfigured build uses the pinned commit below.
HOMETOWN_MOD_I18N_KRISTAL_REF_ENV="${HOMETOWN_MOD_I18N_KRISTAL_REF:-}"
HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION_ENV="${HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION:-}"
HOMETOWN_MOD_I18N_KRISTAL_DIR_ENV="${HOMETOWN_MOD_I18N_KRISTAL_DIR:-}"
KRISTAL_ROOT_ENV="${KRISTAL_ROOT:-}"
HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION_ENV="${HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION:-}"

HOMETOWN_MOD_I18N_KRISTAL_REPO="${HOMETOWN_MOD_I18N_KRISTAL_REPO:-https://github.com/KristalTeam/Kristal.git}"
HOMETOWN_MOD_I18N_KRISTAL_REF="${HOMETOWN_MOD_I18N_KRISTAL_REF:-f62afea63ccab02f468c24ac0d096bd8a2c9aa81}"
HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION="${HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION:-0.11.0-dev}"
HOMETOWN_MOD_I18N_KRISTAL_DIR="${HOMETOWN_MOD_I18N_KRISTAL_DIR:-${KRISTAL_ROOT:-$HOMETOWN_MOD_I18N_MOD_DIR/.build/Kristal}}"
HOMETOWN_MOD_I18N_KRISTAL_SOURCE="${HOMETOWN_MOD_I18N_KRISTAL_SOURCE:-}"
HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION="${HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION:-1}"

HOMETOWN_MOD_I18N_MOD_ID="${HOMETOWN_MOD_I18N_MOD_ID:-hometown-mod-i18n}"
HOMETOWN_MOD_I18N_PROJECT_TITLE="${HOMETOWN_MOD_I18N_PROJECT_TITLE:-Hometown Mod}"
HOMETOWN_MOD_I18N_OUTPUT_BASENAME="${HOMETOWN_MOD_I18N_OUTPUT_BASENAME:-hometown-mod-i18n}"
HOMETOWN_MOD_I18N_EXE_BASENAME="${HOMETOWN_MOD_I18N_EXE_BASENAME:-HOMETOWN-MOD-I18N}"
HOMETOWN_MOD_I18N_LOVE_VERSION="${HOMETOWN_MOD_I18N_LOVE_VERSION:-11.5}"
HOMETOWN_MOD_I18N_LOVE_ARCH="${HOMETOWN_MOD_I18N_LOVE_ARCH:-win64}"
HOMETOWN_MOD_I18N_LOVE_WINDOWS_ZIP_URL="${HOMETOWN_MOD_I18N_LOVE_WINDOWS_ZIP_URL:-https://github.com/love2d/love/releases/download/${HOMETOWN_MOD_I18N_LOVE_VERSION}/love-${HOMETOWN_MOD_I18N_LOVE_VERSION}-${HOMETOWN_MOD_I18N_LOVE_ARCH}.zip}"
HOMETOWN_MOD_I18N_BUILD_VARIANTS="${HOMETOWN_MOD_I18N_BUILD_VARIANTS:-release debug}"
HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE="${HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE:-1}"
HOMETOWN_MOD_I18N_BUILD_LOVE="${HOMETOWN_MOD_I18N_BUILD_LOVE:-1}"
HOMETOWN_MOD_I18N_UPDATE_REPOS="${HOMETOWN_MOD_I18N_UPDATE_REPOS:-0}"

# --- icons (all optional) ----------------------------------------------------
# Convention: <mod-root>/assets/icon/{window_icon.png, win/, android/}.
# Every step is skipped (with a warning) when the icon file or the required
# tool is missing, so the default build is unchanged without any icons.
HOMETOWN_MOD_I18N_ICON_DIR="${HOMETOWN_MOD_I18N_ICON_DIR:-$HOMETOWN_MOD_I18N_MOD_DIR/assets/icon}"
HOMETOWN_MOD_I18N_WINDOW_ICON="${HOMETOWN_MOD_I18N_WINDOW_ICON:-$HOMETOWN_MOD_I18N_ICON_DIR/window_icon.png}"
HOMETOWN_MOD_I18N_WIN_ICON_DIR="${HOMETOWN_MOD_I18N_WIN_ICON_DIR:-$HOMETOWN_MOD_I18N_ICON_DIR/win}"
HOMETOWN_MOD_I18N_RCEDit="${HOMETOWN_MOD_I18N_RCEDit:-}"          # empty → probe $HOMETOWN_MOD_I18N_TOOLS_DIR/rcedit/ and PATH
HOMETOWN_MOD_I18N_ICON_FETCH_TOOLS="${HOMETOWN_MOD_I18N_ICON_FETCH_TOOLS:-0}"  # 1 = auto-download rcedit
HOMETOWN_MOD_I18N_RCEDit_URL="${HOMETOWN_MOD_I18N_RCEDit_URL:-https://github.com/electron/rcedit/releases/download/v2.0.0/rcedit-x64.exe}"
# wine prefix lives OUTSIDE the mod tree: wine creates a `z: -> /` symlink
# under it, and LÖVE recursively scans the mod root at runtime — a loop
# there makes getInfo return nil and crashes the game at startup.
HOMETOWN_MOD_I18N_WINE_PREFIX="${HOMETOWN_MOD_I18N_WINE_PREFIX:-${XDG_CACHE_HOME:-$HOME/.cache}/hometown-mod-i18n/wine}"

log() {
    printf '[build] %s\n' "$*" >&2
}

fail() {
    printf '[错误] %s\n' "$*" >&2
    exit 1
}

# Track the variant being built so an interrupted build (failure or Ctrl+C)
# can remove its partial outputs from dist. A build that dies after writing
# `-release.love` but before its win64 zip must not leave a lone release.love
# behind — that reads as "only the release .love was built" when the real
# situation is that the variant never finished. Cleanup keys off a completion
# flag, not $?, because $? is unreliable inside signal traps.
HOMETOWN_MOD_I18N_CURRENT_VARIANT=""
HOMETOWN_MOD_I18N_BUILD_FINISHED=0
cleanup_partial_build() {
    local status=$?
    if [ "$HOMETOWN_MOD_I18N_BUILD_FINISHED" -ne 1 ] && [ -n "$HOMETOWN_MOD_I18N_CURRENT_VARIANT" ]; then
        local stem="$HOMETOWN_MOD_I18N_OUTPUT_DIR/${HOMETOWN_MOD_I18N_OUTPUT_BASENAME}-${HOMETOWN_MOD_I18N_CURRENT_VARIANT}"
        if [ -e "$stem.love" ] || [ -e "$stem-${HOMETOWN_MOD_I18N_LOVE_ARCH}.zip" ] \
            || [ -d "$stem-${HOMETOWN_MOD_I18N_LOVE_ARCH}" ]; then
            printf '[错误] 变体 %s 构建失败/中断，已移除 dist 中未完成的部分输出\n' \
                "$HOMETOWN_MOD_I18N_CURRENT_VARIANT" >&2
            rm -f "$stem.love" "$stem-${HOMETOWN_MOD_I18N_LOVE_ARCH}.zip"
            rm -rf "$stem-${HOMETOWN_MOD_I18N_LOVE_ARCH}"
        fi
    fi
    exit "$status"
}
trap cleanup_partial_build EXIT INT TERM

need_cmd() {
    command -v "$1" >/dev/null 2>&1 || fail "Missing required command: $1"
}

# --- icon helpers (all optional; every failure only skips that icon step) ----

# Is the host actually Windows (Git Bash uname is MINGW*/MSYS*)? rcedit is a
# native Windows exe, so we run it directly there and via wine elsewhere.
is_windows_host() {
    case "$(uname -s)" in
        MINGW*|MSYS*|CYGWIN*) return 0 ;;
        *) return 1 ;;
    esac
}

# Resolve the rcedit binary: 1) HOMETOWN_MOD_I18N_RCEDit 2) $HOMETOWN_MOD_I18N_TOOLS_DIR/rcedit/
# 3) rcedit on PATH. Returns the path or exits 1.
resolve_rcedit() {
    local bin="${HOMETOWN_MOD_I18N_RCEDit:-}"
    if [ -n "$bin" ]; then
        [ -f "$bin" ] && { printf '%s\n' "$bin"; return 0; }
        command -v "$bin" >/dev/null 2>&1 && { command -v "$bin"; return 0; }
        return 1
    fi
    if [ -f "$HOMETOWN_MOD_I18N_TOOLS_DIR/rcedit/rcedit-x64.exe" ]; then
        printf '%s\n' "$HOMETOWN_MOD_I18N_TOOLS_DIR/rcedit/rcedit-x64.exe"
        return 0
    fi
    command -v rcedit >/dev/null 2>&1 && { command -v rcedit; return 0; }
    return 1
}

# Auto-download rcedit into $HOMETOWN_MOD_I18N_TOOLS_DIR/rcedit/ (gated by
# HOMETOWN_MOD_I18N_ICON_FETCH_TOOLS=1).
fetch_rcedit() {
    local dest="$HOMETOWN_MOD_I18N_TOOLS_DIR/rcedit/rcedit-x64.exe"
    [ -f "$dest" ] && { printf '%s\n' "$dest"; return 0; }
    [ "$HOMETOWN_MOD_I18N_ICON_FETCH_TOOLS" = "1" ] || return 1
    command -v curl >/dev/null 2>&1 || return 1
    log "下载 rcedit（用于 Windows exe 图标）"
    mkdir -p "$(dirname "$dest")"
    curl --fail --location --output "$dest" "$HOMETOWN_MOD_I18N_RCEDit_URL" || {
        rm -f "$dest"
        warn "下载 rcedit 失败，跳过 exe 图标注入"
        return 1
    }
    printf '%s\n' "$dest"
}

# Produce a .ico for the Windows exe. Prefers a ready-made icon.ico, else
# combines win/*.png with icotool (or ImageMagick) into <out_dir>/game.ico.
# Prints the .ico path, or nothing when no usable source/tool exists.
resolve_win_ico() {
    local out_dir="$1" ico png pngs=()
    # Always create the output dir: build_variant copies love.exe into
    # $out_dir/love-icon.exe whether the .ico is ready-made or combined here.
    mkdir -p "$out_dir"
    if [ -f "$HOMETOWN_MOD_I18N_WIN_ICON_DIR/icon.ico" ]; then
        printf '%s\n' "$HOMETOWN_MOD_I18N_WIN_ICON_DIR/icon.ico"
        return 0
    fi
    for png in "$HOMETOWN_MOD_I18N_WIN_ICON_DIR"/[0-9]*x[0-9]*.png; do
        [ -f "$png" ] && pngs+=("$png")
    done
    [ "${#pngs[@]}" -eq 0 ] && return 1
    ico="$out_dir/game.ico"
    if command -v icotool >/dev/null 2>&1; then
        icotool -c -o "$ico" "${pngs[@]}" || return 1
    elif command -v magick >/dev/null 2>&1; then
        magick "${pngs[@]}" "$ico" || return 1
    elif command -v convert >/dev/null 2>&1; then
        convert "${pngs[@]}" "$ico" || return 1
    else
        warn "icotool/ImageMagick 不可用，跳过 exe 图标合成"
        return 1
    fi
    [ -f "$ico" ] && { printf '%s\n' "$ico"; return 0; }
    return 1
}

# Inject a .ico into a love.exe copy. MUST run before `cat` appends the .love
# payload: rcedit rebuilds the PE via EndUpdateResource and would drop any
# bytes appended after the last section. Returns 0 on success or graceful
# skip, 1 only when the injection was attempted but failed.
inject_exe_icon() {
    local exe="$1" ico="$2" rcedit before_sha
    rcedit="$(resolve_rcedit)" || rcedit="$(fetch_rcedit)" || {
        warn "rcedit 不可用，跳过 exe 图标注入: $(basename "$exe")"
        return 0
    }
    if ! is_windows_host; then
        command -v wine >/dev/null 2>&1 || {
            warn "Linux 主机缺 wine，跳过 exe 图标注入: $(basename "$exe")"
            return 0
        }
    fi
    log "注入 exe 图标: $(basename "$exe")"
    before_sha="$(sha256sum "$exe" | awk '{print $1}')"
    if is_windows_host; then
        # rcedit is a native Windows exe and cannot open msys-style paths
        # (/c/Users/...); convert them or it fails with "invalid argument".
        "$rcedit" "$(win_path "$exe")" --set-icon "$(win_path "$ico")" || return 1
    else
        WINEPREFIX="$HOMETOWN_MOD_I18N_WINE_PREFIX" WINEDEBUG=-all \
            wine "$rcedit" "$exe" --set-icon "$ico"
    fi
    # wine can mask a failed rcedit with exit 0; a no-op means the icon was
    # not applied, so fail the step (the caller falls back to the default).
    if [ "$(sha256sum "$exe" | awk '{print $1}')" = "$before_sha" ]; then
        warn "rcedit 未修改 exe（图标可能无效），跳过 exe 图标注入"
        return 1
    fi
}

# The engine only reads window_icon.png from the mod root, so copy the
# convention-located source there and explicitly enable setWindowTitleAndIcon.
stage_window_icon() {
    local stage_mod="$1"
    if [ -f "$HOMETOWN_MOD_I18N_WINDOW_ICON" ]; then
        cp "$HOMETOWN_MOD_I18N_WINDOW_ICON" "$stage_mod/window_icon.png"
        run_helper set-mod-json-flag "$stage_mod/mod.json" setWindowTitleAndIcon true
        log "已暂存 window_icon.png 并置 setWindowTitleAndIcon=true"
    fi
}

detect_kristal_path() {
    local candidate dir parent
    # Same probe as the game launcher (libraries/kristal-debug-tools/bin/kristal-run):
    # local-first — walk up from the mod root for the nearest engine, so a mod
    # sitting inside its own engine fork (e.g. el-mods/ inside kristal-el) is
    # authoritative even when KRISTAL_ROOT is inherited from the shell profile.
    dir="$HOMETOWN_MOD_I18N_MOD_DIR"
    while :; do
        if [ -f "$dir/main.lua" ] && [ -f "$dir/src/kristal.lua" ]; then
            printf '%s\n' "$dir"
            return 0
        fi
        parent=$(dirname "$dir")
        [ "$parent" = "$dir" ] && break
        dir=$parent
    done
    # Explicit env vars are only a fallback for mods outside an engine tree.
    local candidates=()
    [ -n "$HOMETOWN_MOD_I18N_KRISTAL_DIR_ENV" ] && candidates+=("$HOMETOWN_MOD_I18N_KRISTAL_DIR_ENV")
    [ -n "$KRISTAL_ROOT_ENV" ] && candidates+=("$KRISTAL_ROOT_ENV")
    for candidate in "${candidates[@]}"; do
        [ -n "$candidate" ] || continue
        if [ -f "$candidate/main.lua" ]; then
            printf '%s\n' "$candidate"
            return 0
        fi
    done
    candidates+=(
        "$HOMETOWN_MOD_I18N_MOD_DIR/.build/Kristal"
        "$HOMETOWN_MOD_I18N_MOD_DIR/../Kristal"
        "$HOMETOWN_MOD_I18N_MOD_DIR/../kristal"
        "$HOME/Kristal"
        "$HOME/kristal"
    )
    for candidate in "${candidates[@]}"; do
        [ -n "$candidate" ] || continue
        if [ -f "$candidate/main.lua" ]; then
            printf '%s\n' "$candidate"
            return 0
        fi
    done
    return 1
}

choose_kristal_tag() {
    local tags=() tag answer default_tag found i

    while IFS= read -r tag; do
        tags+=("$tag")
    done < <(git ls-remote --tags --refs "$HOMETOWN_MOD_I18N_KRISTAL_REPO" \
        | sed -n 's#.*refs/tags/##p' | sort -V)

    if [ "${#tags[@]}" -eq 0 ]; then
        printf 'Could not list tags from %s\n' "$HOMETOWN_MOD_I18N_KRISTAL_REPO" >&2
        return 1
    fi

    default_tag="${HOMETOWN_MOD_I18N_KRISTAL_REF_ENV:-}"
    found=0
    for tag in "${tags[@]}"; do
        if [ "$tag" = "$default_tag" ]; then
            found=1
            break
        fi
    done
    if [ "$found" -eq 0 ]; then
        default_tag="${tags[$((${#tags[@]} - 1))]}"
    fi

    printf '远程 tag 列表：\n'
    for i in "${!tags[@]}"; do
        printf '  %2d) %s\n' "$((i + 1))" "${tags[$i]}"
    done
    printf '输入编号或 tag 名 [%s]: ' "$default_tag"
    IFS= read -r answer || return 1
    answer="${answer:-$default_tag}"

    case "$answer" in
        *[!0-9]*)
            for tag in "${tags[@]}"; do
                if [ "$tag" = "$answer" ]; then
                    HOMETOWN_MOD_I18N_KRISTAL_REF="$tag"
                    return 0
                fi
            done
            printf 'Unknown tag: %s\n' "$answer" >&2
            return 1
            ;;
        *)
            if [ "$answer" -ge 1 ] && [ "$answer" -le "${#tags[@]}" ]; then
                HOMETOWN_MOD_I18N_KRISTAL_REF="${tags[$((answer - 1))]}"
                return 0
            fi
            printf 'Invalid tag number: %s\n' "$answer" >&2
            return 1
            ;;
    esac
}

choose_kristal_commit() {
    local hash

    printf '输入完整 commit hash（40 位十六进制；GitHub 不支持用短 hash 直接获取）: '
    IFS= read -r hash || return 1
    hash="$(printf '%s' "$hash" | tr -d '[:space:]')"
    case "$hash" in
        '')
            printf 'Commit hash 不能为空。\n' >&2
            return 1
            ;;
        *[!0-9a-fA-F]*)
            printf 'Commit hash 只能包含十六进制字符。\n' >&2
            return 1
            ;;
    esac
    if [ "${#hash}" -ne 40 ]; then
        printf 'Commit hash 需要完整 40 位。\n' >&2
        return 1
    fi
    HOMETOWN_MOD_I18N_KRISTAL_REF="$hash"
}

choose_kristal_branch() {
    local branches=() branch answer default_branch found i

    default_branch="${HOMETOWN_MOD_I18N_KRISTAL_REF_ENV:-main}"

    while IFS= read -r branch; do
        branches+=("$branch")
    done < <(git ls-remote --heads "$HOMETOWN_MOD_I18N_KRISTAL_REPO" \
        | sed -n 's#.*refs/heads/##p' | sort)

    found=0
    for branch in "${branches[@]}"; do
        if [ "$branch" = "$default_branch" ]; then
            found=1
            break
        fi
    done
    if [ "${#branches[@]}" -gt 0 ] && [ "$found" -eq 0 ]; then
        default_branch="${branches[0]}"
    fi

    if [ "${#branches[@]}" -gt 0 ]; then
        printf '远程分支列表：\n'
        for i in "${!branches[@]}"; do
            printf '  %2d) %s\n' "$((i + 1))" "${branches[$i]}"
        done
        printf '输入编号或分支名（取该分支最新提交）[%s]: ' "$default_branch"
    else
        printf '（无法列出远程分支）输入分支名（取该分支最新提交）[%s]: ' "$default_branch"
    fi
    IFS= read -r answer || return 1
    answer="${answer:-$default_branch}"

    case "$answer" in
        *[!0-9]*)
            HOMETOWN_MOD_I18N_KRISTAL_REF="$answer"
            ;;
        *)
            if [ "$answer" -ge 1 ] && [ "$answer" -le "${#branches[@]}" ]; then
                HOMETOWN_MOD_I18N_KRISTAL_REF="${branches[$((answer - 1))]}"
            else
                HOMETOWN_MOD_I18N_KRISTAL_REF="$answer"
            fi
            ;;
    esac
    [ -n "$HOMETOWN_MOD_I18N_KRISTAL_REF" ] || HOMETOWN_MOD_I18N_KRISTAL_REF="$default_branch"
}

choose_kristal_source() {
    local local_path choice default_choice custom_path

    local_path="$(detect_kristal_path || true)"
    default_choice=3
    if [ -n "$local_path" ]; then
        default_choice=1
    fi

    while :; do
        printf '\n选择 Kristal 引擎来源：\n'
        if [ -n "$local_path" ]; then
            printf '  1) 使用本地 Kristal（%s）\n' "$local_path"
        else
            printf '  1) 使用本地 Kristal（未检测到，先选 2 输入路径）\n'
        fi
        printf '  2) 自己输入本地路径\n'
        printf '  3) 从 Git 远程选择 tag（列出远程 tag）\n'
        printf '  4) 从 Git 远程输入 commit hash\n'
        printf '  5) 从 Git 远程选择分支（取该分支最新提交，默认 main）\n'
        printf '请选择 [1-5，默认 %s]: ' "$default_choice"
        IFS= read -r choice || return 1
        choice="${choice:-$default_choice}"

        case "$choice" in
            1)
                if [ -z "$local_path" ]; then
                    printf '没有找到可用的本地 Kristal。\n' >&2
                    continue
                fi
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=local
                HOMETOWN_MOD_I18N_KRISTAL_DIR="$local_path"
                if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" ]; then
                    HOMETOWN_MOD_I18N_KRISTAL_REF=HEAD
                fi
                ;;
            2)
                printf '本地 Kristal 路径: '
                IFS= read -r custom_path || return 1
                custom_path="${custom_path#"${custom_path%%[![:space:]]*}"}"
                custom_path="${custom_path%"${custom_path##*[![:space:]]}"}"
                custom_path="${custom_path//\\//}"
                case "$custom_path" in
                    '~'|'~/'*) custom_path="$HOME${custom_path#\~}" ;;
                esac
                [ -n "$custom_path" ] || {
                    printf '路径不能为空。\n' >&2
                    continue
                }
                custom_path="$(CDPATH= cd -- "$custom_path" && pwd -P)" || {
                    printf '无法解析路径: %s\n' "$custom_path" >&2
                    continue
                }
                if [ ! -f "$custom_path/main.lua" ]; then
                    printf '路径不是有效的 Kristal 目录（缺少 main.lua）: %s\n' "$custom_path" >&2
                    continue
                fi
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=path
                HOMETOWN_MOD_I18N_KRISTAL_DIR="$custom_path"
                if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" ]; then
                    HOMETOWN_MOD_I18N_KRISTAL_REF=HEAD
                fi
                ;;
            3)
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=tag
                if ! choose_kristal_tag; then
                    continue
                fi
                ;;
            4)
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=commit
                if ! choose_kristal_commit; then
                    continue
                fi
                ;;
            5)
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=branch
                if ! choose_kristal_branch; then
                    continue
                fi
                ;;
            *)
                printf '无效选项: %s\n' "$choice" >&2
                continue
                ;;
        esac
        break
    done

    if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION_ENV" ] \
        && [ -z "$HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION_ENV" ]; then
        case "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE:$HOMETOWN_MOD_I18N_KRISTAL_REF" in
            commit:f62afea63ccab02f468c24ac0d096bd8a2c9aa81) HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION=1 ;;
            *) HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION=0 ;;
        esac
    fi
}

resolve_kristal_source() {
    if [ "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" = "ask" ]; then
        HOMETOWN_MOD_I18N_KRISTAL_SOURCE=""
        choose_kristal_source
        return 0
    fi

    if [ -n "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" ]; then
        case "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" in
            local|path)
                if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" ]; then
                    HOMETOWN_MOD_I18N_KRISTAL_REF=HEAD
                fi
                ;;
            commit)
                case "$HOMETOWN_MOD_I18N_KRISTAL_REF" in
                    ''|*[!0-9a-fA-F]*)
                        fail "HOMETOWN_MOD_I18N_KRISTAL_SOURCE=commit requires a 40-hex HOMETOWN_MOD_I18N_KRISTAL_REF"
                        ;;
                esac
                if [ "${#HOMETOWN_MOD_I18N_KRISTAL_REF}" -ne 40 ]; then
                    fail "HOMETOWN_MOD_I18N_KRISTAL_SOURCE=commit requires a 40-hex HOMETOWN_MOD_I18N_KRISTAL_REF"
                fi
                ;;
            tag)
                [ -n "$HOMETOWN_MOD_I18N_KRISTAL_REF" ] \
                    || fail "HOMETOWN_MOD_I18N_KRISTAL_SOURCE=tag requires HOMETOWN_MOD_I18N_KRISTAL_REF"
                ;;
            branch)
                [ -n "$HOMETOWN_MOD_I18N_KRISTAL_REF" ] \
                    || fail "HOMETOWN_MOD_I18N_KRISTAL_SOURCE=branch requires HOMETOWN_MOD_I18N_KRISTAL_REF"
                ;;
        esac
        if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION_ENV" ] \
            && [ -z "$HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION_ENV" ]; then
            case "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE:$HOMETOWN_MOD_I18N_KRISTAL_REF" in
                commit:f62afea63ccab02f468c24ac0d096bd8a2c9aa81) HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION=1 ;;
                *) HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION=0 ;;
            esac
        fi
        return 0
    fi

    # Explicit paths and refs retain their inferred source type. With no
    # override, both interactive and CI builds use the pinned commit below.
    if [ -n "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" ] \
        && [ "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" != "f62afea63ccab02f468c24ac0d096bd8a2c9aa81" ]; then
        case "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" in
            *[!0-9a-fA-F]*)
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=tag
                ;;
            *)
                HOMETOWN_MOD_I18N_KRISTAL_SOURCE=commit
                ;;
        esac
    elif [ -n "$HOMETOWN_MOD_I18N_KRISTAL_DIR_ENV" ] || [ -n "$KRISTAL_ROOT_ENV" ]; then
        HOMETOWN_MOD_I18N_KRISTAL_SOURCE=local
        if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_REF_ENV" ]; then
            HOMETOWN_MOD_I18N_KRISTAL_REF=HEAD
        fi
    else
        HOMETOWN_MOD_I18N_KRISTAL_SOURCE=commit
    fi

    if [ -z "$HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION_ENV" ] \
        && [ -z "$HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION_ENV" ]; then
        case "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE:$HOMETOWN_MOD_I18N_KRISTAL_REF" in
            commit:f62afea63ccab02f468c24ac0d096bd8a2c9aa81) HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION=1 ;;
            *) HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION=0 ;;
        esac
    fi
}

fetch_kristal_ref() {
    local dir="$1" ref="$2" remote

    remote="$(git -C "$dir" remote | head -n 1)"
    [ -n "$remote" ] || fail "No Git remote configured in $dir"

    if [ "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" = "tag" ]; then
        git -C "$dir" fetch --depth 1 "$remote" "refs/tags/${ref}:refs/tags/${ref}"
    elif [ "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" = "branch" ]; then
        # Mirror the branch tip into a local branch of the same name so every
        # later use of $ref (checkout --detach / git show / git archive) resolves.
        # The '+' force-prefix is required: on a shallow --depth 1 fetch the new
        # tip shares no history with the cached local branch, so without it git
        # rejects the update (non-fast-forward) and "latest commit" would fail
        # on the second and later runs.
        git -C "$dir" fetch --depth 1 "$remote" "+refs/heads/${ref}:refs/heads/${ref}"
    else
        git -C "$dir" fetch --depth 1 "$remote" "$ref"
    fi
}

ensure_kristal() {
    local dir="$HOMETOWN_MOD_I18N_KRISTAL_DIR"

    case "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" in
        local|path)
            [ -d "$dir" ] || fail "Kristal local path does not exist: $dir"
            [ -f "$dir/main.lua" ] || fail "Kristal local path is missing main.lua: $dir"
            if git -C "$dir" rev-parse --git-dir >/dev/null 2>&1; then
                HOMETOWN_MOD_I18N_KRISTAL_IS_GIT=1
                git -C "$dir" rev-parse --verify --quiet "${HOMETOWN_MOD_I18N_KRISTAL_REF}^{commit}" >/dev/null \
                    || fail "Local Kristal checkout does not contain ${HOMETOWN_MOD_I18N_KRISTAL_REF}: $dir"
                if [ "$HOMETOWN_MOD_I18N_UPDATE_REPOS" = "1" ]; then
                    local remote
                    remote="$(git -C "$dir" remote | head -n 1)"
                    if [ -n "$remote" ]; then
                        git -C "$dir" fetch --depth 1 --tags "$remote"
                    fi
                fi
            else
                HOMETOWN_MOD_I18N_KRISTAL_IS_GIT=0
            fi
            ;;
        tag|commit|branch)
            if git -C "$dir" rev-parse --git-dir >/dev/null 2>&1; then
                HOMETOWN_MOD_I18N_KRISTAL_IS_GIT=1
                if [ "$HOMETOWN_MOD_I18N_UPDATE_REPOS" = "1" ]; then
                    local remote
                    remote="$(git -C "$dir" remote | head -n 1)"
                    if [ -n "$remote" ]; then
                        git -C "$dir" fetch --depth 1 --tags "$remote"
                    fi
                fi
                if [ "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" = "branch" ]; then
                    # A branch means "latest commit": always refresh the tip so a
                    # cached checkout never silently serves an older commit.
                    fetch_kristal_ref "$dir" "$HOMETOWN_MOD_I18N_KRISTAL_REF"
                elif ! git -C "$dir" rev-parse --verify --quiet "${HOMETOWN_MOD_I18N_KRISTAL_REF}^{commit}" >/dev/null; then
                    fetch_kristal_ref "$dir" "$HOMETOWN_MOD_I18N_KRISTAL_REF"
                fi
                git -C "$dir" -c advice.detachedHead=false checkout --detach "$HOMETOWN_MOD_I18N_KRISTAL_REF" >/dev/null
            elif [ -e "$dir" ]; then
                fail "Kristal path exists but is not a Git checkout: $dir"
            else
                HOMETOWN_MOD_I18N_KRISTAL_IS_GIT=1
                mkdir -p "$(dirname "$dir")"
                if [ "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" = "tag" ]; then
                    log "Shallow-cloning Kristal tag ${HOMETOWN_MOD_I18N_KRISTAL_REF} from $HOMETOWN_MOD_I18N_KRISTAL_REPO"
                    git -c advice.detachedHead=false clone --depth 1 --branch "$HOMETOWN_MOD_I18N_KRISTAL_REF" --single-branch \
                        "$HOMETOWN_MOD_I18N_KRISTAL_REPO" "$dir"
                else
                    if [ "$HOMETOWN_MOD_I18N_KRISTAL_SOURCE" = "branch" ]; then
                        log "Shallow-fetching Kristal branch ${HOMETOWN_MOD_I18N_KRISTAL_REF} from $HOMETOWN_MOD_I18N_KRISTAL_REPO"
                    else
                        log "Shallow-fetching Kristal commit ${HOMETOWN_MOD_I18N_KRISTAL_REF} from $HOMETOWN_MOD_I18N_KRISTAL_REPO"
                    fi
                    git init -q "$dir"
                    git -C "$dir" remote add origin "$HOMETOWN_MOD_I18N_KRISTAL_REPO"
                    fetch_kristal_ref "$dir" "$HOMETOWN_MOD_I18N_KRISTAL_REF"
                fi
                if ! git -C "$dir" -c advice.detachedHead=false checkout --detach "$HOMETOWN_MOD_I18N_KRISTAL_REF" >/dev/null 2>&1; then
                    git -C "$dir" -c advice.detachedHead=false checkout --detach HEAD >/dev/null
                    HOMETOWN_MOD_I18N_KRISTAL_REF=HEAD
                fi
            fi
            ;;
        *)
            fail "Unknown Kristal source: ${HOMETOWN_MOD_I18N_KRISTAL_SOURCE:-<empty>}"
            ;;
    esac

    if [ "$HOMETOWN_MOD_I18N_KRISTAL_IS_GIT" = "1" ]; then
        version="$(git -C "$dir" show "${HOMETOWN_MOD_I18N_KRISTAL_REF}:VERSION" | tr -d '\r\n')"
    elif [ -f "$dir/VERSION" ]; then
        version="$(sed -n '1p' "$dir/VERSION" | tr -d '\r\n')"
    else
        version=""
    fi

    if [ "$HOMETOWN_MOD_I18N_KRISTAL_VERIFY_VERSION" = "1" ]; then
        if [ "$version" != "$HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION" ]; then
            fail "Kristal ${HOMETOWN_MOD_I18N_KRISTAL_REF} reports VERSION=$version, expected $HOMETOWN_MOD_I18N_KRISTAL_EXPECTED_VERSION"
        fi
    else
        log "Using Kristal VERSION=$version (${HOMETOWN_MOD_I18N_KRISTAL_REF:+ref ${HOMETOWN_MOD_I18N_KRISTAL_REF}})"
    fi
}

export_kristal() {
    stage_dir="$1"
    rm -rf "$stage_dir"
    mkdir -p "$stage_dir"
    if [ "$HOMETOWN_MOD_I18N_KRISTAL_IS_GIT" = "1" ]; then
        git -C "$HOMETOWN_MOD_I18N_KRISTAL_DIR" archive --format=tar "$HOMETOWN_MOD_I18N_KRISTAL_REF" \
            | tar -x -C "$stage_dir"
    else
        # Exclude mods/: a mod sitting inside the engine's mods/ folder (the
        # walk-up engine detection supports this) would otherwise be archived
        # into the stage, dragging along .build and re-copying the stage into
        # itself (unbounded growth). The staged engine's mods/ is removed below
        # anyway — the mod is inserted separately by copy_mod.
        #
        # Exclude .tools/ too: it is the shared per-machine tool cache
        # (<kristal-root>/.tools, auto-downloaded JDK/Android SDK/GUI/PortableGit),
        # not part of the game. On Windows the Temurin JDK's broken junctions
        # (same PHYSFS family as the filesystemutils.lua crash) make the LÖVE zip
        # helper's file scan die mid-zip, aborting the build with a partial .love.
        # The git path above never sees these (untracked); the tar fallback must
        # drop them explicitly. .build/ is defensive (never ship build artifacts).
        tar -cf - --exclude='./.git' --exclude='./mods' --exclude='./.tools' \
            --exclude='./.build' -C "$HOMETOWN_MOD_I18N_KRISTAL_DIR" . \
            | tar -xf - -C "$stage_dir"
    fi
    rm -rf "$stage_dir/.github" "$stage_dir/mods" "$stage_dir/build" "$stage_dir/output"
}

copy_mod() {
    stage_mod="$1"
    variant="$2"
    mkdir -p "$stage_mod"
    # Stage with tar instead of rsync (rsync is not available in Git Bash
    # on Windows; tar is). Member names are "./…", so a leading "./" pins a
    # pattern to the mod root, while slash-free patterns match basenames
    # anywhere (like rsync's unanchored patterns).
    tar -cf - \
        --exclude='*.git' \
        --exclude='./.github' \
        --exclude='./.build' \
        --exclude='./dist*' \
        --exclude='./.tools' \
        --exclude='./.emacs' \
        --exclude='./.helix' \
        --exclude='./.vscode' \
        --exclude='./.worktrees' \
        --exclude='./tests' \
        --exclude='./docs' \
        --exclude='./Makefile' \
        --exclude='./justfile' \
        --exclude='./tools' \
        --exclude='./build-helper' \
        --exclude='__pycache__' \
        --exclude='*.pyc' \
        --exclude='*.pyo' \
        --exclude='./release-please-config.json' \
        --exclude='./.release-please-manifest.json' \
        --exclude='./.gitmodules' \
        --exclude='./.gitignore' \
        --exclude='*.tiled-project' \
        --exclude='*.tiled-session' \
        --exclude='./libraries/kristal-debug-tools/gui' \
        --exclude='./libraries/kristal-debug-tools-gui' \
        --exclude='./libraries/kristal-debug-tools/just.cmd' \
        --exclude='./libraries/kristal-debug-tools/dist' \
        --exclude='./libraries/kristal-debug-tools/.tools' \
        --exclude='./assets/icon' \
        -C "$HOMETOWN_MOD_I18N_MOD_DIR" . | tar -xf - -C "$stage_mod"

    if [ "$variant" = "release" ]; then
        rm -rf "$stage_mod/libraries/kristal-object-selector-plus"
        rm -rf "$stage_mod/libraries/terminal-cli"
        rm -rf "$stage_mod/libraries/kristal-debug-tools"
    fi
}

prepare_stage() {
    variant="$1"
    case "$variant" in
        release)
            release_mode=true
            mod_dev=false
            object_editor=false
            ;;
        debug)
            release_mode=false
            mod_dev=true
            object_editor=true
            ;;
        *)
            fail "Unknown build variant: $variant"
            ;;
    esac

    stage_dir="$HOMETOWN_MOD_I18N_BUILD_ROOT/$variant/source"
    export_kristal "$stage_dir"
    stage_mod="$stage_dir/mods/$HOMETOWN_MOD_I18N_MOD_ID"
    copy_mod "$stage_mod" "$variant"
    if [ "$variant" = "release" ]; then
        identity="$HOMETOWN_MOD_I18N_MOD_ID"
        title="$HOMETOWN_MOD_I18N_PROJECT_TITLE"
    else
        identity="${HOMETOWN_MOD_I18N_MOD_ID}_debug"
        title="${HOMETOWN_MOD_I18N_PROJECT_TITLE} Debug"
    fi
    run_helper patch-lua-config \
        "$stage_dir" "$HOMETOWN_MOD_I18N_MOD_ID" "$release_mode" \
        "$identity" "$title"
    if [ "${HOMETOWN_MOD_I18N_ANDROID_TOUCH_SKIP_INTRO:-0}" = "1" ]; then
        run_helper patch-android-loading-touch \
            "$stage_dir/src/engine/loadstate.lua"
    fi
    run_helper patch-mod-manifest \
        "$stage_mod/mod.json" "$mod_dev" "$object_editor"
    stage_window_icon "$stage_mod"
    # stage_dir is set above as a side effect; return it via a global so this
    # function is NOT called inside $(...) — a command substitution disables
    # `set -e` for the whole body, which would silently swallow a failed
    # run_helper (e.g. a patch that no longer matches) and ship a broken build.
}

ensure_love_windows() {
    [ "$HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE" = "1" ] || return 0
    mkdir -p "$HOMETOWN_MOD_I18N_CACHE_DIR"
    love_zip="$HOMETOWN_MOD_I18N_CACHE_DIR/love-${HOMETOWN_MOD_I18N_LOVE_VERSION}-${HOMETOWN_MOD_I18N_LOVE_ARCH}.zip"
    love_dir="$HOMETOWN_MOD_I18N_CACHE_DIR/love-${HOMETOWN_MOD_I18N_LOVE_VERSION}-${HOMETOWN_MOD_I18N_LOVE_ARCH}"
    if [ ! -f "$love_zip" ] || [ ! -s "$love_zip" ]; then
        rm -f "$love_zip"
        log "正在下载 LÖVE ${HOMETOWN_MOD_I18N_LOVE_VERSION} ${HOMETOWN_MOD_I18N_LOVE_ARCH}，用于生成 Windows 可执行文件"
        curl --fail --location --retry 3 --retry-delay 2 \
            --output "$love_zip" "$HOMETOWN_MOD_I18N_LOVE_WINDOWS_ZIP_URL" || {
            rm -f "$love_zip"
            fail "下载 LÖVE ${HOMETOWN_MOD_I18N_LOVE_VERSION} ${HOMETOWN_MOD_I18N_LOVE_ARCH} 失败（$HOMETOWN_MOD_I18N_LOVE_WINDOWS_ZIP_URL）。请检查网络后重试；也可手动下载并放到 $love_zip"
        }
    fi
    if [ ! -d "$love_dir" ]; then
        extract_dir="$HOMETOWN_MOD_I18N_CACHE_DIR/love-${HOMETOWN_MOD_I18N_LOVE_VERSION}-${HOMETOWN_MOD_I18N_LOVE_ARCH}.extract"
        rm -rf "$extract_dir"
        mkdir -p "$extract_dir"
        unzip -q "$love_zip" -d "$extract_dir"
        extracted="$(find "$extract_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
        [ -n "$extracted" ] || {
            fail 'Could not locate the extracted LÖVE directory'
        }
        mv "$extracted" "$love_dir"
        rm -rf "$extract_dir"
    fi
    if [ ! -f "$love_dir/love.exe" ]; then
        rm -rf "$love_dir" "$love_zip"
        fail "LÖVE ${HOMETOWN_MOD_I18N_LOVE_VERSION} 缓存损坏（缺少 love.exe），已清除缓存，请重试构建"
    fi
}

build_variant() {
    variant="$1"
    HOMETOWN_MOD_I18N_CURRENT_VARIANT="$variant"
    log "开始构建变体: $variant"
    prepare_stage "$variant"
    if [ "$HOMETOWN_MOD_I18N_BUILD_LOVE" = "1" ]; then
        love_output_dir="$HOMETOWN_MOD_I18N_OUTPUT_DIR"
    else
        love_output_dir="$HOMETOWN_MOD_I18N_BUILD_ROOT/love"
    fi
    love_file="$love_output_dir/${HOMETOWN_MOD_I18N_OUTPUT_BASENAME}-${variant}.love"
    zip_dir "$love_file" "$stage_dir"

    if [ "$HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE" = "1" ]; then
        love_dir="$HOMETOWN_MOD_I18N_CACHE_DIR/love-${HOMETOWN_MOD_I18N_LOVE_VERSION}-${HOMETOWN_MOD_I18N_LOVE_ARCH}"
        package_name="${HOMETOWN_MOD_I18N_OUTPUT_BASENAME}-${variant}-${HOMETOWN_MOD_I18N_LOVE_ARCH}"
        package_dir="$HOMETOWN_MOD_I18N_OUTPUT_DIR/$package_name"
        exe_name="${HOMETOWN_MOD_I18N_EXE_BASENAME}-${variant}.exe"
        rm -rf "$package_dir"
        mkdir -p "$package_dir"
        # Inject the icon into a copy of love.exe BEFORE cat appends the .love
        # payload (rcedit rebuilds the PE and would drop appended bytes).
        local ico="" icon_love="$love_dir/love.exe" candidate
        ico="$(resolve_win_ico "$HOMETOWN_MOD_I18N_BUILD_ROOT/$variant/icon" || true)"
        if [ -n "$ico" ]; then
            candidate="$HOMETOWN_MOD_I18N_BUILD_ROOT/$variant/icon/love-icon.exe"
            cp "$love_dir/love.exe" "$candidate"
            if inject_exe_icon "$candidate" "$ico"; then
                icon_love="$candidate"
            else
                warn "exe 图标注入失败，回退默认图标"
            fi
        fi
        cat "$icon_love" "$love_file" > "$package_dir/$exe_name"
        cp "$love_dir"/*.dll "$package_dir/"
        test ! -f "$love_dir/license.txt" || cp "$love_dir/license.txt" "$package_dir/"
        zip_dir "$HOMETOWN_MOD_I18N_OUTPUT_DIR/${package_name}.zip" "$package_dir" "$package_name"
        # The zip is the deliverable: drop the unpacked staging folder so dist
        # stays clean (the folder holds exactly what the zip contains).
        if [ -s "$HOMETOWN_MOD_I18N_OUTPUT_DIR/${package_name}.zip" ]; then
            rm -rf "$package_dir"
        else
            fail "Windows package zip was not created: $HOMETOWN_MOD_I18N_OUTPUT_DIR/${package_name}.zip"
        fi
    fi

    if [ "$HOMETOWN_MOD_I18N_BUILD_LOVE" != "1" ] \
        && [ "$HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE" = "1" ]; then
        rm -f "$love_file"
    fi
}

# shellcheck source=build-helper/lib.sh
source "$HOMETOWN_MOD_I18N_MOD_DIR/build-helper/lib.sh"
need_git
need_cmd tar
need_cmd unzip
need_cmd curl
# `zip` is optional: when missing, zip_dir falls back to the build-helper
# (LÖVE) which writes stored zips.
if [ "$HOMETOWN_MOD_I18N_BUILD_LOVE" != "1" ] \
    && [ "$HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE" != "1" ]; then
    fail "Nothing to build: set HOMETOWN_MOD_I18N_BUILD_LOVE=1 and/or HOMETOWN_MOD_I18N_BUILD_WINDOWS_EXE=1"
fi
resolve_kristal_source
ensure_kristal
mkdir -p "$HOMETOWN_MOD_I18N_OUTPUT_DIR"
ensure_love_windows
for variant in $HOMETOWN_MOD_I18N_BUILD_VARIANTS; do
    build_variant "$variant"
done
# All variants succeeded: the EXIT/INT/TERM trap must not clean dist.
HOMETOWN_MOD_I18N_BUILD_FINISHED=1
HOMETOWN_MOD_I18N_CURRENT_VARIANT=""
log "构建完成，输出目录: $HOMETOWN_MOD_I18N_OUTPUT_DIR"
open_output_dir "$HOMETOWN_MOD_I18N_OUTPUT_DIR"
