#!/bin/bash

# Ensure an input directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

TARGET_DIR="$1"

# Verify the directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

# Find all .adoc files (excluding any named main.adoc) and process them
find "$TARGET_DIR" -type f -name "*.adoc" ! -name "main.adoc" -print0 | while IFS= read -r -d '' INPUT_FILE; do
    echo "Converting: $INPUT_FILE"
    TMP_FILE=$(mktemp)

    awk '
    BEGIN {
        has_content_type = 0
        has_abstract = 0
    }
    { 
        # Read the entire file into an array line-by-line
        lines[NR] = $0 
        
        # Check if the specific tags already exist anywhere in the file
        if ($0 ~ /^:_mod-docs-content-type:/) {
            has_content_type = 1
        }
        if ($0 ~ /^\[role="_abstract"\]/) {
            has_abstract = 1
        }
    }
    END {
        # Rule 5: Add :_mod-docs-content-type: only if it is missing
        if (has_content_type == 0) {
            print ":_mod-docs-content-type:"
            print ""
        }

        i = 1
        seen_h1 = 0
        added_abstract = 0

        while (i <= NR) {
            # Rule 4: Remove inline links that are standalone bullet points (* <<text>>)
            if (lines[i] ~ /^\s*\* <<.*>>\s*$/) {
                i += 1
                continue
            }

            # Track when we pass the Level 1 Header (= )
            if (lines[i] ~ /^= /) {
                seen_h1 = 1
            } 
            # Rule 6: Find the first paragraph after Level 1 Header and add [role="_abstract"] (if missing)
            else if (seen_h1 == 1 && added_abstract == 0 && has_abstract == 0) {
                # A paragraph is the first line that is NOT empty, NOT an AsciiDoc attribute (:),
                # and NOT a comment (//).
                if (lines[i] !~ /^\s*$/ && lines[i] !~ /^:/ && lines[i] !~ /^\/\//) {
                    print "[role=\"_abstract\"]"
                    added_abstract = 1
                }
            }

            # Rule 2: Replace "== Prerequisites" and its preceding line
            if (i < NR && lines[i+1] ~ /^== Prerequisites\s*$/) {
                print ".Prerequisites"
                i += 2
                continue
            }

            # Rule 3: Replace "== Additional resources" and its preceding line
            if (i < NR && lines[i+1] ~ /^== Additional resources\s*$/) {
                print ".Additional resources"
                i += 2
                continue
            }

            # Rule 1: Remove anchors directly above ==, ===, or ==== headers
            if (i < NR && lines[i] ~ /^\[\[.*\]\]\s*$|^\[#.*\]\s*$/ && lines[i+1] ~ /^={2,4} /) {
                # Skip printing the anchor line
                i += 1
                continue
            }

            # If no rules match, print the current line normally
            print lines[i]
            i += 1
        }
    }
    ' "$INPUT_FILE" > "$TMP_FILE"

    # Overwrite the original file with the modified content
    mv "$TMP_FILE" "$INPUT_FILE"
done

echo "---"
echo "Successfully processed all target .adoc files in: $TARGET_DIR (skipped main.adoc)"
