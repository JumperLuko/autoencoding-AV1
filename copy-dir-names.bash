#!/bin/bash

SRC_DIR="$1"
DST_DIR="$2"

## Copy the directories to the destination directory, not the files inside
IFS=$'\n'
for dir in $(find "$SRC_DIR" -type d); do
## Old "while" loop, has some bug with name with spaces
# find "$SRC_DIR" -type f ! -name "*.mp4" | while read file; do

  rel_path=${dir#$SRC_DIR}
  target_path="$DST_DIR$rel_path"

  # Check if the target directory already exists.  If not, create it.
  if [ ! -d "$target_path" ]; then
    mkdir -p "$target_path"
    echo "Created directory: $target_path"
  else
    echo "Directory already exists: $target_path"
  fi
done
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo ""
echo "COPY DIRECTORY SCRIPT Done!"
echo ""
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="