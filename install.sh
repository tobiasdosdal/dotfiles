#!/bin/bash

# Dotfiles installer
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Top-level files to symlink
files=(".zshrc" ".p10k.zsh" ".fzf.zsh" ".gitconfig")

# Config files to symlink
config_files=("ghostty/config")

for file in "${files[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  if [[ -f "$dest" && ! -L "$dest" ]]; then
    echo "Backing up existing $file to $file.backup"
    mv "$dest" "$dest.backup"
  fi

  echo "Linking $file"
  ln -sf "$src" "$dest"
done

mkdir -p "$HOME/.config"
for cfg in "${config_files[@]}"; do
  src="$DOTFILES_DIR/.config/$cfg"
  dest="$HOME/.config/$cfg"

  mkdir -p "$(dirname "$dest")"

  if [[ -f "$dest" && ! -L "$dest" ]]; then
    echo "Backing up existing .config/$cfg to .config/$cfg.backup"
    mv "$dest" "$dest.backup"
  fi

  echo "Linking .config/$cfg"
  ln -sf "$src" "$dest"
done

echo "Done! Restart your terminal or run: source ~/.zshrc"
