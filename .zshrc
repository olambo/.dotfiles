# User configuration sourced by interactive shells

# based on https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
setopt prompt_subst
autoload -Uz vcs_info
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad;
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
if [[ $(whoami) == "red" ]]; then
  PROMPT='%F{red}%n%F{240} $vcs_info_msg_0_:%F{59}%2~%f >> '
else
  PROMPT='%F{240}%n $vcs_info_msg_0_:%F{59}%2~%f >> '
fi


export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH

if [[ $(uname 2> /dev/null) == "Linux" ]] ; then
    alias ls='ls --color=auto'
fi

# -----------------------------------------------------------------------------------------------------------
# have to have 'bindkey -v' before '~/.fzf.zsh'
bindkey -v 
bindkey -r ''
# beginning and end of line inside and outside of vi mode
bindkey "\033[H" beginning-of-line 
bindkey "\033[F" end-of-line
source $HOME/.config/zsh-vim-mode/zsh-vim-mode.plugin.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS=" --extended --color hl:202,hl+:202"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# -----------------------------------------------------------------------------------------------------------

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi='fvim() { nvim +":cd %:p:h" ${@:-.} };~/.config/nvim/bin/vclipboard-start;fvim'
alias doc='vi ~/notes'
alias con='vi ~/.config/nvim'
alias ip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' |head -1"
alias fi='open -a Finder .'
alias dev='cd ~/dev'
alias vcommand-start='~/.config/nvim/bin/vcommand-start'
