# User configuration sourced by interactive shells
#

PROMPT='%F{240}%T%f:%F{green}%~%f %% '
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit && compinit
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
PROMPT='$vcs_info_msg_0_:%F{green}%~%f %% '
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Change default zim location
# export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
# [[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

export extrHost=rest.extractor.fos
export extrHost=localhost:24000
export extrApiKey=44a15b05-2321-4767-a05b-b927fd599d48
export extrSecretKey=4430187d-e427-4ee4-90f9-1e0d6efe35a8
export crawleeUN=extractor
export crawleePW=cRawlee#123
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTFILE=~/.zhistory
export XARGS=gxargs
export GRAALVM_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java11-19.3.0/Contents/Home

setopt hist_ignore_dups
setopt hist_ignore_space

# export PATH="$HOME/.jenv/bin:$PATH#
#  eval "$(jenv init -)"

alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias vi='fvim() { nvim ${@:-.} };fvim'

alias dev='cd ~/dev'
alias wrk='cd ~/dev/wrk'

alias doc='vi ~/Dropbox/doc'
alias con='vi ~/.config'

alias mdo='mvn clean install -Dmaven.test.skip=true'
alias ip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' |head -1"
alias bak='~/Dropbox/yeBackup/bak'
alias skag='sk --ansi -i -c "ag --color \"{}\""'

alias fin='open -a Finder .'

alias cpp='pbpaste -pboard find | pbcopy'
alias ppp='pbpaste -pboard find'

function h() {
  osascript -e 'tell application "System Events" to keystroke "r" using {control down, shift down, option down, command down}'
}

function cdd() {
  clipboard="$(pbpaste -pboard find | sed s/\[\'\"]//)"
  if [ -d "$clipboard" ]; then
    dir=$clipboard
  elif [ -f "$clipboard" ]; then
    dir=$(dirname $clipboard)
  fi
  cd $dir
}

function vii() {
  clipboard="$(pbpaste -pboard find)"
  if [ -d "$clipboard" ]; then
    f=$clipboard
  elif [ -f "$clipboard" ]; then
    f=$clipboard
  fi
  vi $f
}

function skk() { 
    vi $(find . -name '*.scala' | sk -m ) 
}

bindkey -v 
bindkey '^A' vi-beginning-of-line
bindkey -M vicmd '^A' vi-beginning-of-line
bindkey '^E' end-of-line
bindkey -M vicmd '^E' end-of-line
bindkey -r ''

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias skg='git ls-tree -r --name-only HEAD |sk'
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || ag -l -g \"\"  || find ."
export FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD "
export FZF_DEFAULT_OPTS=" --extended --color hl:202,hl+:202"
export SKIM_DEFAULT_OPTS=" --extended --color hl:202,hl+:202"

export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH

