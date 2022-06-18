# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# User configuration sourced by interactive shells

eval "$(lua /usr/local/Cellar/z.lua/1.8.15/share/z.lua/z.lua --init zsh)"

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

export PATH=~/.config/nvim/bin:~/go/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH:/opt/homebrew/bin

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
alias rvi='fvim() { nvim ${@:-.} };fvim'
alias vi='fvim() { nvim --cmd "let g:useMetals=1" ${@:-.} };fvim'
# ln -s ~/Library/Mobile\ Documents/*byword/Documents ~/.byworddoc
alias doc='cd ~/.byworddoc; vi ~/.byworddoc'
alias con='vi +":cd ~/.config/nvim" ~/.config/nvim'
alias ip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' |head -1"
alias fi='open -a Finder .'
alias dev='cd ~/dev'
alias c='cd  $(z |sort +1 -r| fzf --height=40% --layout=reverse| cut -d" " -f2-)'
alias v=~/.config/nvim/bin/viFZF
alias vcd='cd `cat ~/.config/nvim/runcache/viDirFZF`'

export PATH=$PATH:$HOME/Library/Application\ Support/Coursier/bin

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
