#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd -P)"
HOMETOWN_PACK_BUILD_DIR="${HOMETOWN_PACK_MOD_BUILD_DIR:-$ROOT/.build/mod}"
HOMETOWN_PACK_OUTPUT_DIR="${HOMETOWN_PACK_OUTPUT_DIR:-$ROOT/dist}"
HOMETOWN_PACK_OUTPUT_FILE="${HOMETOWN_PACK_MOD_OUTPUT_FILE:-$HOMETOWN_PACK_OUTPUT_DIR/hometown-pack-mod.zip}"
STAGE_DIR="$HOMETOWN_PACK_BUILD_DIR/source"

command -v python3 >/dev/null
command -v rsync >/dev/null
command -v unzip >/dev/null
command -v zip >/dev/null

rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR" "$HOMETOWN_PACK_OUTPUT_DIR"
rsync -a \
    --exclude='/.git/' \
    --exclude='.git' \
    --exclude='/.github/' \
    --exclude='/.build/' \
    --exclude='/dist/' \
    --exclude='/.emacs/' \
    --exclude='/.helix/' \
    --exclude='/.vscode/' \
    --exclude='/.worktrees/' \
    --exclude='/tests/' \
    --exclude='/docs/' \
    --exclude='/Makefile' \
    --exclude='/justfile' \
    --exclude='/build_standalone.sh' \
    --exclude='/build_standalone.py' \
    --exclude='/build_android.sh' \
    --exclude='__pycache__/' \
    --exclude='*.pyc' \
    --exclude='*.pyo' \
    --exclude='/release-please-config.json' \
    --exclude='/.release-please-manifest.json' \
    --exclude='/.gitmodules' \
    --exclude='/.gitignore' \
    --exclude='*.tiled-project' \
    --exclude='*.tiled-session' \
    "$ROOT/" "$STAGE_DIR/"

rm -rf "$STAGE_DIR/libraries/object-editor"
rm -rf "$STAGE_DIR/libraries/terminal-cli"
rm -rf "$STAGE_DIR/libraries/kristal-debug-tools"
python3 "$ROOT/build_standalone.py" patch-mod-manifest "$STAGE_DIR/mod.json" false false
rm -f "$HOMETOWN_PACK_OUTPUT_FILE"
(cd "$STAGE_DIR" && zip -9 -q -r "$HOMETOWN_PACK_OUTPUT_FILE" .)
test -s "$HOMETOWN_PACK_OUTPUT_FILE"
unzip -t "$HOMETOWN_PACK_OUTPUT_FILE" >/dev/null
unzip -Z1 "$HOMETOWN_PACK_OUTPUT_FILE" | grep -Fx 'mod.json' >/dev/null
printf 'Created Mod package: %s\n' "$HOMETOWN_PACK_OUTPUT_FILE"
