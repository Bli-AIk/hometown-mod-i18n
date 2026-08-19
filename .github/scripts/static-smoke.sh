#!/bin/sh
set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")/../.." && pwd -P)

test -f "$root/mod.lua"
test -f "$root/mod.json"
grep -Fqx '    "id": "hometown-mod-i18n",' "$root/mod.json"
test -f "$root/lang/en.json"
test -f "$root/lang/zh_hans.json"
test -f "$root/lang/names.json"
test -f "$root/scripts/world/maps/light/hometown/torielhouse/kris_room/kris_room.tmx"
test -f "$root/libraries/kristal-i18n/lib.lua"
test -f "$root/libraries/kristal-object-selector-plus/lib.lua"
test -f "$root/libraries/terminal-cli/lib.lua"
test -f "$root/libraries/kristal-debug-tools/lib.lua"
test -f "$root/libraries/virtualkeyboard/lib.lua"
test -f "$root/libraries/weatherlib/lib.lua"
grep -Fq '| [v0.11.0-dev]' "$root/libraries/virtualkeyboard/README.md"
grep -Fq '| [v0.11.0-dev]' "$root/libraries/protag-kun_library/readme_el.md"
grep -Fq '| [v0.11.0-dev]' "$root/libraries/weatherlib/README.md"
grep -F '"version": "v1.1.1"' "$root/libraries/weatherlib/lib.json" >/dev/null
grep -F '"engineVer": "v0.11.0-dev"' "$root/libraries/weatherlib/lib.json" >/dev/null
grep -F '"engineVer": "v0.11.0-dev"' "$root/mod.json" >/dev/null
grep -F '"lightInventory": {' "$root/mod.json" >/dev/null
if grep -F '"inventory": {' "$root/mod.json" >/dev/null; then
    printf '%s\n' 'mod.json must use lightInventory on Kristal 0.11.0-dev' >&2
    exit 1
fi
luajit -b "$root/libraries/virtualkeyboard/lib.lua" /dev/null
