# User configuration sourced by interactive shells
#

# based on https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
setopt prompt_subst
autoload -Uz vcs_info
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
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
PROMPT='%F{240}%n $vcs_info_msg_0_:%F{green}%~%f %% '

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

alias dotf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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
bindkey -r ''
# the following bindkey's won't work in macos Terminal without also adding them to Profiles/Keyboard
bindkey "\033[H" beginning-of-line 
bindkey "\033[F" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias skg='git ls-tree -r --name-only HEAD |sk'
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || ag -l -g \"\"  || find ."
export FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD "
export FZF_DEFAULT_OPTS=" --extended --color hl:202,hl+:202"
export SKIM_DEFAULT_OPTS=" --extended --color hl:202,hl+:202"

export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH

