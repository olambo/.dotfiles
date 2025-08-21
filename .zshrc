# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

# ============================================================================
# VI MODE AND KEY BINDINGS
# ============================================================================
# Sets the shell to vi mode for command-line editing. This allows you to use
# Vim-style navigation and commands directly in the terminal. The `bindkey -v`
# command must be placed before sourcing any plugins that rely on vi mode,
# such as fzf.

# Custom key bindings are set here to ensure the Home and End keys work as
# expected, moving the cursor to the beginning and end of the line.

# The zsh-vim-mode plugin is sourced to provide more advanced vi-like
# functionality and a smoother editing experience.
#
bindkey -v 
# Beginning and end of line inside and outside of vi mode
bindkey "\033[H" beginning-of-line 
bindkey "\033[F" end-of-line
source $HOME/.config/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# ============================================================================
# FZF CONFIGURATION
# ============================================================================
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS=" --extended --color hl:202,hl+:202"

# ============================================================================
# ALIASES
# ============================================================================
# Dotfiles management
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Editor shortcuts
alias con='vi +":cd ~/.config/nvim" ~/.config/nvim'
alias doc='vi ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Vaultdoc/'
# Launch nvim with current directory as default (opens Dirvish file browser when no args provided)
alias vi='fvim() { nvim ${@:-.} }; fvim'

# System utilities
alias ip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' |head -1"
alias finder='open -a Finder .'
alias python=python3

# Quick reference file viewer
refs() {
  local files=(
    "$HOME/.config/nvim/vim-keymaps-reference.md"
    "$HOME/.config/karabiner/karabiner-reference.md"
    "$HOME/.hammerspoon/hammerspoon-reference.md"
  )
  
  local selected=$(printf "%s\n" "${files[@]}" | fzf --prompt="Reference: ")
  
  [[ -n "$selected" ]] && nvim -R "$selected"
}

# Development utilities
alias combineit='for f in $(ls i*.vim bin/lkeyFunctions bin/v* 2>/dev/null); do echo "=== $f ==="; cat "$f" || echo "ERROR: Failed to cat $f"; echo; done > combined.txt'

# Quick file opener vif=all files vip=python and mardown files
vif() { vi $(fzf) }
vip() { vi $(rg -t py -t md --files | fzf) }
