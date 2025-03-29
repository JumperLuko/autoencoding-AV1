#!/bin/bash

# For external files, please mount in some place

# Set the source and destination directories
SRC_DIR="$1"
DST_DIR="$2"

# Ensure target directory exists
mkdir -p "$DST_DIR"

# To read break lines right
IFS=$'\n'
# Loop through all files in the source directory, searching for .mp4 files
for file in $(find "$SRC_DIR" -type f -name "*.mp4"); do
# # Old "for" loop, limited search depth
# for file in "$SRC_DIR"/**/*.mp4; do

  # Get the relative path of the file
  rel_path=${file#$SRC_DIR}
  target_path="$DST_DIR$rel_path"
  target_dir=$(dirname "$target_path")

  # Create the target directory if it doesn't exist
  mkdir -p "$target_dir"

  # Encode the file using ffmpeg
  # Try others parameters if needed 
  # check the threads
  # I usually like this, because 40 CRF compress well in already little hard compressed mp4, preset 8 is fast and not ugly. 96k opus audio is almost transparent
  # ffmpeg -n -threads 0 -i "$file" -c:v libsvtav1 -crf 40 -preset 8 -b:v 0 -b:a 96k -c:a libopus "$target_path.webm";

  ## Super compress
  ffmpeg -n -threads 0 -i "$file" -c:v libsvtav1 -preset 8 -b:v 10k -b:a 12k -c:a libopus -r 10 -pix_fmt yuv420p -vf scale=480:-1 "$target_path.webm"

  # # Test outputs
  # echo "$file"
  # exit
  # echo "$file" | grep "Apostilas"
  # echo "$rel_path"
  # echo "$target_path"
done
# NOTE: How to remove the old file extensions?
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo ""
echo "ENCODE Done!"
echo ""
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

# # UNCOMMENT THIS TO COPY OTHER FILES
# # Copy the not mp4 files to the destination directory
# IFS=$'\n'
# for file in $(find "$SRC_DIR" -type f ! -name "*.mp4"); do
# # # Old "while" loop, has some bug with name with spaces
# # find "$SRC_DIR" -type f ! -name "*.mp4" | while read file; do

#   rel_path=${file#$SRC_DIR}
#   target_path="$DST_DIR$rel_path"
#   target_dir=$(dirname "$target_path")
#   mkdir -p "$target_dir"
#   cp "$file" "$target_path"
# done
# echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
# echo ""
# echo "COPY OTHERS FILES Done!"
# echo ""
# echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="


echo ""
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo ""
echo "SCRIPT Done!"
echo ""
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="