#! /bin/bash

is_running=`ps -ax | awk '/[p]rocess-clipboard/{print $1}'`
if [ -n "$is_running" ]; then
  echo process-clipboard already running at $is_running
  exit
fi

vc_file=~/.config/nvim/runcache/vim-clipboard.txt

mkdir -p ~/.config/nvim/runcache
ls "$vc_file" | entr ~/.config/nvim/bin/process-clipboard.sh &
