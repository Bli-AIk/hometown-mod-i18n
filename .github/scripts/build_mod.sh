#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd -P)"
HOMETOWN_MOD_I18N_MOD_DIR="$ROOT"
HOMETOWN_MOD_I18N_BUILD_DIR="${HOMETOWN_MOD_I18N_MOD_BUILD_DIR:-$ROOT/.build/mod}"
HOMETOWN_MOD_I18N_OUTPUT_DIR="${HOMETOWN_MOD_I18N_OUTPUT_DIR:-$ROOT/dist}"
HOMETOWN_MOD_I18N_OUTPUT_FILE="${HOMETOWN_MOD_I18N_MOD_OUTPUT_FILE:-$HOMETOWN_MOD_I18N_OUTPUT_DIR/hometown-mod-i18n-mod.zip}"
# Same icon conventions as build_standalone.sh (defaults, but honour overrides).
HOMETOWN_MOD_I18N_ICON_DIR="${HOMETOWN_MOD_I18N_ICON_DIR:-$ROOT/assets/icon}"
HOMETOWN_MOD_I18N_WINDOW_ICON="${HOMETOWN_MOD_I18N_WINDOW_ICON:-$HOMETOWN_MOD_I18N_ICON_DIR/window_icon.png}"
STAGE_DIR="$HOMETOWN_MOD_I18N_BUILD_DIR/source"

# `zip` is optional: when missing, the build-helper (LÖVE) writes the zip.

# shellcheck source=build-helper/lib.sh
source "$ROOT/build-helper/lib.sh"
command -v unzip >/dev/null 2>&1 || fail 'Missing required command: unzip'

rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR" "$HOMETOWN_MOD_I18N_OUTPUT_DIR"
# Stage with tar instead of rsync (rsync is not available in Git Bash on
# Windows; tar is). Member names are "./…": a leading "./" pins a pattern to
# the mod root, slash-free patterns match basenames anywhere.
tar -cf - \
    --exclude='*.git' \
    --exclude='./.github' \
    --exclude='./libraries/*/.github' \
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
    -C "$ROOT" . | tar -xf - -C "$STAGE_DIR"

rm -rf "$STAGE_DIR/libraries/kristal-object-selector-plus"
rm -rf "$STAGE_DIR/libraries/terminal-cli"
rm -rf "$STAGE_DIR/libraries/kristal-debug-tools"
run_helper patch-mod-manifest "$STAGE_DIR/mod.json" false false
if [ -f "$HOMETOWN_MOD_I18N_WINDOW_ICON" ]; then
    cp "$HOMETOWN_MOD_I18N_WINDOW_ICON" "$STAGE_DIR/window_icon.png"
    run_helper set-mod-json-flag "$STAGE_DIR/mod.json" setWindowTitleAndIcon true
fi
zip_dir "$HOMETOWN_MOD_I18N_OUTPUT_FILE" "$STAGE_DIR" ""
test -s "$HOMETOWN_MOD_I18N_OUTPUT_FILE"
unzip -t "$HOMETOWN_MOD_I18N_OUTPUT_FILE" >/dev/null
unzip -Z1 "$HOMETOWN_MOD_I18N_OUTPUT_FILE" | grep -Fx 'mod.json' >/dev/null
printf 'Created Mod package: %s\n' "$HOMETOWN_MOD_I18N_OUTPUT_FILE"
open_output_dir "$HOMETOWN_MOD_I18N_OUTPUT_DIR"
