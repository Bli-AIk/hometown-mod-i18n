#!/bin/sh
set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")/../.." && pwd -P)

test -f "$root/mod.lua"
test -f "$root/mod.json"
grep -Fqx '    "id": "hometown_pack",' "$root/mod.json"
grep -Fqx '    "engine": "kristal-el",' "$root/mod.json"
test -f "$root/lang/en.json"
test -f "$root/lang/zh_hans.json"
test -f "$root/lang/names.json"
test -f "$root/scripts/world/maps/light/hometown/torielhouse/kris_room/kris_room.tmx"
test -f "$root/libraries/kristal-i18n/lib.lua"
test -f "$root/libraries/object-editor/lib.lua"
test -f "$root/libraries/terminal-cli/lib.lua"
test -f "$root/libraries/kristal-debug-tools/lib.lua"
test -f "$root/libraries/virtualkeyboard/lib.lua"
test -f "$root/libraries/weatherlib/lib.lua"
luajit -b "$root/libraries/virtualkeyboard/lib.lua" /dev/null
