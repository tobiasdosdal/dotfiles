#!/bin/bash

# Dotfiles installer
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Files to symlink
files=(".zshrc" ".p10k.zsh" ".fzf.zsh" ".gitconfig")

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

echo "Done! Restart your terminal or run: source ~/.zshrc"
