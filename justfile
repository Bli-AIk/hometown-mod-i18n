default: test

# Run this Mod through the parent Kristal EL checkout.
run *args:
    @.github/scripts/run-el.sh {{ args }}

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
