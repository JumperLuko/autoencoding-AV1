#!/bin/bash

## UNCOMMENT THIS TO COPY OTHER FILES
## Copy the not mp4 files to the destination directory
IFS=$'\n'
for file in $(find "$SRC_DIR" -type f ! -name "*.mp4"); do
## Old "while" loop, has some bug with name with spaces
# find "$SRC_DIR" -type f ! -name "*.mp4" | while read file; do

  rel_path=${file#$SRC_DIR}
  target_path="$DST_DIR$rel_path"
  target_dir=$(dirname "$target_path")
  mkdir -p "$target_dir"
  cp "$file" "$target_path"
  echo "Copied $file"
done
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo ""
echo "COPY OTHERS FILES Done!"
echo ""
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="