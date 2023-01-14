#!/usr/bin/env bash

STOW_FOLDERS="karabiner,nvim"
TARGET="$HOME"

for folder in ${STOW_FOLDERS//,/ }
do
    stow -v -t "$TARGET" "$folder"
done

echo "Finished symlinking files"
