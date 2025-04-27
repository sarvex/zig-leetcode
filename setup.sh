#!/bin/bash

# Remove all files except JS and TS files
find . -type f -not -name "*.c" -not -name "*.cpp" -not -name "*.zig" -delete

# Process JS and TS files - move up two levels and rename
for ext in c cpp zig; do
  find . -name "*.$ext" -type f | while read -r file; do
    dir=$(basename "$(dirname "$file")")
    up=$(dirname "$(dirname "$(dirname "$(dirname "$file")")")")
    mv -n "$file" "$up/$dir.zig"
  done
done

echo "Setup completed successfully!"
