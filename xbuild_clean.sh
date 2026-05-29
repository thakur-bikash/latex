#!/bin/bash

opened=0

for file in *.tex; do
    # Skip if no .tex files exist in the directory
    [ -e "$file" ] || continue

    # Compile the file
    xelatex "$file"

    # Extract the base filename without the .tex extension
    base="${file%.tex}"

    # Find and delete all matching files except the source (.tex) and output (.pdf)
    find . -maxdepth 1 -type f -name "${base}.*" ! -name "${base}.tex" ! -name "${base}.pdf" -delete

    # Open the first compiled PDF in the background and update the flag
    if [ "$opened" -eq 0 ]; then
        xdg-open "${base}.pdf" &>/dev/null &
        opened=1
    fi
done
