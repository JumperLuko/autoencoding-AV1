#!/bin/bash

# PLEASE, RUN 2 TIMES THIS SCRIPT, I don't know why this bug :(
# And for external files, please mount in some place

# Please use / in the end of the path

# Set the source and destination directories
SRC_DIR="$1"
DST_DIR="$2"

# Ensure target directory exists
mkdir -p "$DST_DIR"
# echo "$SRC_DIR"
# echo "$DST_DIR"

# # Create folders, separately, because, unknown problems
# find "$SRC_DIR" -type f -name "*.mp4" | while read file; do
# 	rel_path=${file#$SRC_DIR}
# 	target_path="$DST_DIR$rel_path"
#   target_dir=$(dirname "$target_path")
# 	mkdir -p "$target_dir"
#   # echo "$rel_path"
#   # echo "$target_path"
#   # echo "$target_dir"
#   # echo "$file"
#   # exit
# done

# echo ""

  # Use find to scan all the folders and files in the source directory
  for file in "$SRC_DIR"**/*.mp4; do
    # Get the relative path of the file
    rel_path=${file#$SRC_DIR}
    target_path="$DST_DIR$rel_path"
    target_dir=$(dirname "$target_path")
    
    # echo "$file"
    # echo ""
    ffmpeg -n -threads 16 -i "$file" -c:v libsvtav1 -crf 63 -preset 13 -b:v 0 -c:a libvorbis "$target_path.webm";
    # $(ffmpeg -n -threads 16 -i "$file" -c:v libsvtav1 -crf 40 -preset 8 -b:v 0 -c:a libvorbis "$target_path.webm") 2>&1 && sleep 3 || sleep 0.5;
    # unset rel_path target_path target_dir;
    # echo "$file"
    # echo "$target_path.webm"
    # echo "$target_dir"
    # exit
  done



# # Use find to scan all the folders and files in the source directory
# find "$SRC_DIR" -type f -name "*.mp4" | while read file; do
#   # Get the relative path of the file
#   rel_path=${file#$SRC_DIR/}

#   # Create the destination directory if it doesn't exist
#   #dst_dir="$DST_DIR/$rel_path"
#   #dst_dir=${dst_dir%/*}
#   #mkdir -p "$dst_dir"
#   target_path="$DST_DIR/$rel_path"
#   target_dir=$(dirname "$target_path")
#   #mkdir -p "$target_dir"
  

#   # Run the ffmpeg command to convert the mp4 file to webm
#   #ffmpeg -i "$file" -c:v libsvtav1 -crf 50 -preset 13 -b:v 0 -c:a libvorbis "$dst_dir/${file##*/}.webm"
#   #echo "$file" 
#   #echo "$dst_dir/${file##*/}.webm"
  
#   ffmpeg -n -i "$file" -c:v libsvtav1 -crf 50 -preset 13 -b:v 0 -c:a libvorbis "$target_path.webm"
#   #my_function () {
#     #filef=$file
#     #pathf=$target_path.webm
    
#     #echo ffmpeg -i "$file" -c:v libsvtav1 -crf 50 -preset 13 -b:v 0 -c:a libvorbis "$target_path.webm"
#   #}
#   #my_function
#   #echo "Converted $file to $target_path.webm"
#   #echo "---"
#   #echo ffmpeg -i "$file" -c:v libsvtav1 -crf 50 -preset 13 -b:v 0 -c:a libvorbis "$target_path.webm"
# done



# #!/bin/bash

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