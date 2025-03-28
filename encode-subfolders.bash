#!/bin/bash

# And for external files, please mount in some place

# Set the source and destination directories
SRC_DIR="$1"
DST_DIR="$2"

# Ensure target directory exists
mkdir -p "$DST_DIR"


# find "$SRC_DIR" -type f -name "*.mp4" | while read file; do
# 	echo "$file" >> ffmpeg-list.txt
# done

# IFS=$'\n'
# for line in $(cat ./ffmpeg-list.txt); do
#   echo "$line" | grep "Apostilas"
#   # exit
# done

# Create folders
find "$SRC_DIR" -type f -name "*.mp4" | while read file; do
	rel_path=${file#$SRC_DIR}
	target_path="$DST_DIR$rel_path"
  target_dir=$(dirname "$target_path")
	mkdir -p "$target_dir"
done

IFS=$'\n'
for file in $(find "$SRC_DIR" -type f -name "*.mp4"); do
# for file in "$SRC_DIR"/**/*.mp4; do
  # Get the relative path of the file
  rel_path=${file#$SRC_DIR}
  target_path="$DST_DIR$rel_path"
  target_dir=$(dirname "$target_path")

  ffmpeg -n -threads 16 -i "$file" -c:v libsvtav1 -crf 40 -preset 8 -b:v 0 -b:a 96k -c:a libopus "$target_path.webm";

  # echo "$file"
  # exit
  # echo "$file" | grep "Apostilas"
  # echo "$rel_path"
  # echo "$target_path"
done
