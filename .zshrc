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
# Must have 'bindkey -v' before '~/.fzf.zsh'
bindkey -v 
bindkey -r ''
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
alias fi='open -a Finder .'
alias python=python3

# Development utilities
alias combineit='for f in $(ls i*.vim bin/lkeyFunctions bin/v* 2>/dev/null); do echo "=== $f ==="; cat "$f" || echo "ERROR: Failed to cat $f"; echo; done > combined.txt'
alias keys='nvim -R ~/.config/nvim/vim-keymaps-reference.md'
# Quick file opener using your vi alias
vif() { vi $(fzf) }
vip() { vi $(rg -t py -t md --files | fzf) }
