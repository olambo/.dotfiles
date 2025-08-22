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
# PROMPT AND GIT INTEGRATION
# ============================================================================
# Based on https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
setopt prompt_subst
autoload -Uz vcs_info

# Git status in prompt
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr '%F{red}M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{240}[%F{2}%b%F{240}|%F{1}%a%F{240}]%f '
zstyle ':vcs_info:*' formats '%F{240}[%F{2}%b%F{240}] %F{2}%c%F{240}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     [[ $(git ls-files --other --exclude-standard --no-empty-directory| sed q | wc -l | tr -d ' ') == 1 ]] ; then
    hook_com[unstaged]+='%F{1}??%f'
  fi
}

precmd () { vcs_info }

# Different prompt for different users
if [[ $(whoami) == "oli" ]]; then
  PROMPT='%F{red}%n%F{240} $vcs_info_msg_0_:%F{59}%2~%f >> '
else
  PROMPT='%F{white}%n $vcs_info_msg_0_:%F{59}%2~%f >> '
fi

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
dot() {
    if [[ "$1" == "add" && ("$2" == "." || "$2" == "*") ]]; then
        echo "Error: 'dot add .' and 'dot add *' are dangerous with bare repo dotfiles!"
        echo "Use explicit file paths instead: dot add path/to/file"
        return 1
    fi
    git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

alias dev='cd ~/dev/'

# Editor shortcuts
alias con='cd ~/.config/nvim && nvim .'
alias doc='cd ~/dev/notes && nvim .'
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
alias combineit='for f in $(ls i*.vim bin/lkeyFunctions vim-keymaps-reference.md 2>/dev/null); do echo "=== $f ==="; cat "$f" || echo "ERROR: Failed to cat $f"; echo; done > combined.txt'

# Quick file opener vif=all files vip=python and mardown files
vif() { vi $(fzf) }
vip() { vi $(rg -t py -t md --files | fzf) }

