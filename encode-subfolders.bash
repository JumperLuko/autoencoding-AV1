#!/bin/bash

# Please use / in the end of the path
# And for external files, please mount in some place

# Set the source and destination directories
SRC_DIR="$1"
DST_DIR="$2"

# Ensure target directory exists
mkdir -p "$DST_DIR"

# Create folders
find "$SRC_DIR" -type f -name "*.mp4" | while read file; do
	rel_path=${file#$SRC_DIR}
	target_path="$DST_DIR$rel_path"
  target_dir=$(dirname "$target_path")
	mkdir -p "$target_dir"
done

# Use all the folders and files in the source directory
# "for" is needed, because with "read" and "while" has some bug with ffmpeg
for file in "$SRC_DIR"**/*.mp4; do
  # Get the relative path of the file
  rel_path=${file#$SRC_DIR}
  target_path="$DST_DIR$rel_path"
  target_dir=$(dirname "$target_path")

  ffmpeg -n -threads 16 -i "$file" -c:v libsvtav1 -crf 40 -preset 8 -b:v 0 -c:a libvorbis "$target_path.webm";
done

## Original generated
# # Set the source and destination directories
# SRC_DIR=/path/to/source/directory
# DST_DIR=/path/to/destination/directory

# # Use find to scan all the folders and files in the source directory
# find "$SRC_DIR" -type f -name "*.mp4" -print0 | while IFS= read -r -d '' file; do
#   # Get the relative path of the file
#   rel_path=${file#$SRC_DIR/}

#   # Create the destination directory if it doesn't exist
#   dst_dir="$DST_DIR/$rel_path"
#   dst_dir=${dst_dir%/*}
#   mkdir -p "$dst_dir"

#   # Run the ffmpeg command to convert the mp4 file to webm
#   ffmpeg -i "$file" -c:v libvpx -crf 10 -b:v 0 -c:a libvorbis "$dst_dir/${file##*/}.webm"
# done