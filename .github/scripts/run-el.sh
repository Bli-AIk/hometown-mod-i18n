#!/bin/sh
set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")/../.." && pwd -P)
engine_root=${KRISTAL_EL_ROOT:-}

if [ -z "$engine_root" ] && [ "${KRISTAL_DEBUG_TOOLS_DRY_RUN:-0}" = "1" ]; then
    engine_root=${KRISTAL_ROOT:-}
fi

if [ -z "$engine_root" ]; then
    for candidate in \
        "$root/../.." \
        "$root/.." \
        "$HOME/Projects/LuaProjects/kristal-el" \
        "$HOME/Projects/kristal-el" \
        "$HOME/kristal-el"
    do
        if [ -f "$candidate/main.lua" ]; then
            engine_root=$(CDPATH='' cd -- "$candidate" && pwd -P)
            break
        fi
    done
fi

if [ -z "$engine_root" ] || [ ! -f "$engine_root/main.lua" ]; then
    printf '%s\n' 'Kristal EL engine not found. Set KRISTAL_EL_ROOT=/path/to/kristal-el,' >&2
    printf '%s\n' 'or run from a checkout inside the engine (el-mods/hometown_pack).' >&2
    exit 1
fi

if [ "${KRISTAL_DEBUG_TOOLS_DRY_RUN:-0}" != "1" ]; then
    grep -Fqx 'EL_ENGINE_ID = "kristal-el"' "$engine_root/src/engine/vendcust.lua"
    test -d "$engine_root/el-mods"
fi

KRISTAL_ROOT="$engine_root" \
KRISTAL_MOD_ROOT="$root" \
    exec just --justfile "$root/libraries/kristal-debug-tools/justfile" run "$@"
