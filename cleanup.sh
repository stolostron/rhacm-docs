#!/bin/bash

# Check if a directory path was passed as an argument
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

DIR="$1"

# Verify the provided argument is a valid directory
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' not found."
    exit 1
fi

echo "Scanning for .adoc files in: $DIR"

# Use find to locate all .adoc files, safely handling filenames with spaces
find "$DIR" -type f -name "*.adoc" -print0 | while IFS= read -r -d '' file; do
    
    awk '
    BEGIN {
        in_procedure = 0
        in_resources = 0
    }
    {
        # 1. Detect the .Procedure block title
        if ($0 ~ /^\.Procedure[ \t]*$/) {
            print $0
            in_procedure = 1
            in_resources = 0
            next
        }

        # State 1: Line immediately following .Procedure
        if (in_procedure == 1) {
            if ($0 ~ /^[ \t]*$/) {
                # Skip the blank line preceding the paragraph
                in_procedure = 2
                next
            } else if ($0 ~ /^\.[ \t]/ || $0 ~ /^\*/ || $0 ~ /^\[/ || $0 ~ /^=/) {
                # Reached a list item (. or *), block attribute ([), or heading (=) directly
                print $0
                in_procedure = 0
                next
            } else {
                # Reached text without a blank line; skip it and switch to state 2
                in_procedure = 2
                next
            }
        } 
        
        # State 2: Processing the intro paragraph text itself
        else if (in_procedure == 2) {
            if ($0 ~ /^[ \t]*$/) {
                # A blank line signifies the end of the intro paragraph.
                # Print this blank line to preserve spacing before the steps.
                print $0
                in_procedure = 0
                next
            } else if ($0 ~ /^\.[ \t]/ || $0 ~ /^\*/ || $0 ~ /^\[/ || $0 ~ /^=/) {
                # Reached a step, attribute, or heading without a trailing blank line
                print $0
                in_procedure = 0
                next
            } else {
                # This is a text line belonging to the intro paragraph; skip it
                next
            }
        }

        # 2. Detect the .Additional Resources block title (or section heading)
        if ($0 ~ /^\.Additional [rR]esources[ \t]*$/ || $0 ~ /^={1,4} Additional [rR]esources[ \t]*$/) {
            print $0
            in_resources = 1
            next
        }

        # Detect the end of the Additional Resources section
        if (in_resources == 1 && ($0 ~ /^\.[A-Z]/ || $0 ~ /^=/)) {
            in_resources = 0
        }

        # Process lines within Additional Resources
        if (in_resources == 1) {
            # Keep blank lines for formatting preservation
            if ($0 ~ /^[ \t]*$/) {
                print $0
                next
            }
            
            # Check if the line contains AsciiDoc link syntax
            if ($0 ~ /link:/ || $0 ~ /xref:/ || $0 ~ /http:\/\// || $0 ~ /https:\/\// || $0 ~ /<</) {
                
                # Check if it is a bullet point (*, **, -, .)
                if (match($0, /^[ \t]*(\*+|-|\.+)[ \t]+/)) {
                    bullet = substr($0, RSTART, RLENGTH)
                    
                    # Extract the link part (xref, link, http(s) with brackets, bare http(s), or <<anchors>>)
                    if (match($0, /(xref:[^\]]+\]|link:[^\]]+\]|https?:\/\/[^ \t\]]+\[[^\]]*\]|https?:\/\/[^ \t]+|<<[^>]+>>)/)) {
                        link = substr($0, RSTART, RLENGTH)
                        # Print only the bullet and the link, discarding surrounding text
                        print bullet link
                        next
                    }
                }
                
                # If it has a link but is not a bullet point (or regex missed it), print unmodified
                print $0
                next
            }
            
            # Otherwise, skip (remove the non-link text entirely)
            next
        }

        # Default action: print the line unmodified
        print $0

    }' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"

    echo "Successfully processed: $file"
done

echo "Done!"