#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <tag1> [tag2...]"
    exit 1
fi

catalog_file="$(dirname "$0")/catalog.txt"
[ -f "$catalog_file" ] || { echo "Error: catalog.txt not found"; exit 1; }

tags="$*"
tags_pattern="\\b($(echo "$tags" | sed 's/ /\\b|\\b/g'))\\b"

while IFS='|' read -r binary tag path; do
    if grep -qE "$tags_pattern" <<< "$tag"; then
        expanded_path=$(eval echo "$path")
        for file in $expanded_path; do
            if [ -e "$file" ]; then
                echo "$file"
            fi
        done
    fi
done < "$catalog_file" | sort -u
