# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Using p10k directly
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Powerlevel10k
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# PATH additions
export PATH="$PATH:/usr/local/share/dotnet:$HOME/.dotnet/tools"
export PATH="$PATH:/Applications/Ghostty.app/Contents/MacOS"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# History settings
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS    # No duplicate entries
setopt HIST_FIND_NO_DUPS       # No duplicates when searching
setopt HIST_SAVE_NO_DUPS       # No duplicates when saving
setopt SHARE_HISTORY           # Share history between sessions
setopt HIST_REDUCE_BLANKS      # Remove extra blanks

# Aliases
alias ls="eza"
alias ll="eza -la"
alias la="eza -a"
alias tree="eza --tree"
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias claude='claude --dangerously-skip-permissions'

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf (fuzzy finder) - Ctrl+R for history, Ctrl+T for files
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Plugins (must be near end)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# MOTD - Message of the day
motd() {
  local CYAN='\033[0;36m'
  local GREEN='\033[0;32m'
  local YELLOW='\033[0;33m'
  local DIM='\033[2m'
  local NC='\033[0m'

  # System info
  local date_str=$(date "+%a %b %d, %H:%M")
  local uptime_str=$(uptime | sed 's/.*up //' | sed 's/,.*//' | xargs)
  local disk_str=$(df -h / | awk 'NR==2 {print $4 " free / " $2}')
  local ip_str=$(ipconfig getifaddr en0 2>/dev/null || echo "No WiFi")

  echo ""
  echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  printf "${GREEN}%-12s${NC} %s\n" "Date" "$date_str"
  printf "${GREEN}%-12s${NC} %s\n" "Uptime" "$uptime_str"
  printf "${GREEN}%-12s${NC} %s\n" "Disk" "$disk_str"
  printf "${GREEN}%-12s${NC} %s\n" "IP" "$ip_str"
  echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo "${DIM}Ctrl+R${NC} history  ${DIM}Ctrl+T${NC} files  ${DIM}z${NC} jump  ${DIM}ll${NC} list"
  echo ""
}

# Show MOTD on new interactive shells (not in VSCode/IDE terminals)
if [[ $- == *i* ]] && [[ -z "$VSCODE_INJECTION" ]] && [[ -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  motd
fi
