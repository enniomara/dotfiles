#!/usr/bin/env bash

STOW_FOLDERS="nvim"
TARGET="$HOME"

for folder in ${STOW_FOLDERS//,/ }
do
    stow -v -t "$TARGET" "$folder"
done

echo "Finished symlinking files"
