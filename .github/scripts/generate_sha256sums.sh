#!/usr/bin/env bash
set -euo pipefail

output_dir="${1:-dist}"
manifest="$output_dir/SHA256SUMS"

test -d "$output_dir"

mapfile -t files < <(
    find "$output_dir" -maxdepth 1 -type f \
        \( -name '*.love' -o -name '*-win64.zip' -o -name '*-mod.zip' \) \
        -printf '%f\n' | LC_ALL=C sort
)

if [ "${#files[@]}" -ne 5 ]; then
    printf 'Expected 5 release files in %s, found %s\n' \
        "$output_dir" "${#files[@]}" >&2
    exit 1
fi

(cd "$output_dir" && sha256sum "${files[@]}" > SHA256SUMS)
test -s "$manifest"
