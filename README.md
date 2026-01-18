# Dotfiles

My macOS zsh configuration.

## What's included

- `.zshrc` - Zsh config with oh-my-zsh, powerlevel10k, and QOL improvements
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.fzf.zsh` - Fuzzy finder shell integration
- `.gitconfig` - Git configuration

## Features

- **Powerlevel10k** prompt
- **Auto-suggestions** from history
- **Syntax highlighting** for commands
- **fzf** fuzzy finder (Ctrl+R for history, Ctrl+T for files)
- **zoxide** smart cd
- **eza** modern ls replacement
- **MOTD** with system info on terminal open

## Dependencies

```bash
brew install eza fd zoxide fzf bat ripgrep
brew install zsh-autosuggestions zsh-syntax-highlighting
```

## Install

```bash
git clone https://github.com/tobiasdosdal/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```
