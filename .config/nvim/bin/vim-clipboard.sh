#! /bin/bash

vc_file=~/.config/nvim/runcache/vim-clipboard.txt
mkdir -p ~/.config/nvim/runcache
ls "$vc_file" | entr echo "cat $vc_file | perl -pe 'chomp if eof' | ~/.iterm2/it2copy"
