#!/bin/bash

# Set the target directory
TARGET_DIR="$HOME/gallery/wallpapers/anime"

# Check if the directory exists
if [[ ! -d $TARGET_DIR ]]; then
    echo "Error: Directory '$TARGET_DIR' not found!"
    exit 1
fi

# Populate VALUES array with the files in the directory
VALUES=($(ls "$TARGET_DIR"))

# Use dmenu to select a wallpaper
choice=$(printf "%s\n" "${VALUES[@]}" | dmenu -i -l 20 -p 'Choose a wallpaper:')

# Check if a choice was made
if [[ -z $choice ]]; then
    echo "No selection made. Exiting."
    exit 1
fi

# Set the wallpaper using hsetroot
hsetroot -fill "$TARGET_DIR/$choice"
echo "Wallpaper set to: $choice"

