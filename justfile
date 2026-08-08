default: test

KRISTAL_ROOT := env_var_or_default('KRISTAL_ROOT', env('HOME') + '/Projects/LuaProjects/Kristal')

# Run the Mod with a local Kristal checkout and shared debug tools.
run *args:
    @just --justfile libraries/kristal-debug-tools/justfile run {{ args }}

# Sync this repo into a Kristal checkout's mods/ (LÖVE doesn't follow symlinks).
install-stock:
    @rm -rf {{KRISTAL_ROOT}}/mods/hometown_pack
    @cp -r . {{KRISTAL_ROOT}}/mods/hometown_pack

test:
    @make test

test-kristal:
    @make test-kristal

build:
    @./build_standalone.sh

build-android:
    @./build_android.sh

build-mod:
    @./.github/scripts/build_mod.sh

clean-build:
    rm -rf .build dist
