#!/usr/bin/env bash

# Get the absolute path of the dotfiles directory
DOTFILES_ROOT=$(cd "$(dirname "$0")/.." && pwd)

set -e

echo -e "\n--- Symlinking Dotfiles ---"

# Function to create symlinks with backup
link_file() {
  local src=$1
  local dst=$2

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up existing file: $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  echo "Linking: $src -> $dst"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
}

# 1. Process *.symlink files (map to ~/.*)
echo "Processing standard dotfiles..."
find -H "$DOTFILES_ROOT" -maxdepth 3 -name '*.symlink' -not -path '*/.git/*' | while read -r file; do
  filename=".$(basename "$file" '.symlink')"
  target="$HOME/$filename"
  link_file "$file" "$target"
done

# 2. Process config/* directories (map to ~/.config/*)
echo -e "\nProcessing ~/.config directories..."
for config in "$DOTFILES_ROOT/config"/*; do
  [ -d "$config" ] || continue
  dirname="$(basename "$config")"
  target="$HOME/.config/$dirname"

  # Some applications keep runtime state (logs, sockets, sessions) beside
  # their configuration. A .link-files marker keeps the target directory real
  # and links only the tracked files inside it.
  if [ -f "$config/.link-files" ]; then
    mkdir -p "$target"
    find "$config" -maxdepth 1 -type f ! -name '.link-files' | while read -r file; do
      link_file "$file" "$target/$(basename "$file")"
    done
  else
    link_file "$config" "$target"
  fi
done

echo -e "\nDone! All symlinks updated."
