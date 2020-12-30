# Keep dotfiles in git without symlinks.

This arrangement of dotfiles is based on ideas from [here](https://news.ycombinator.com/item?id=11070797) and [here](https://github.com/anandpiyer/.dotfiles/tree/master/.dotfiles). The idea is to keep all the dotfiles in their original locations.

## First time setup
```
git init --bare $HOME/.dotfiles
alias dot='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot remote add origin git@github.com:${YOUR_GITHUB_REPOSITORY}/.dotfiles.git
```
You'll need to change the remote URL to your git repo. You should also add the `dot` alias command to your `.bashrc` or  `.zshrc`. Now, you can use the `dot` command to do git operation from anywhere in your $HOME directory:

### Operations
```
cd $HOME
dot add .zshrc.conf
dot commit -m "Add .zshrc.conf"
dot push
```
## New machine setup
To set up a new machine, clone the repo to a temporary directory. This is because you might have some default config files in your $HOME which will cause a normal clone to fail.
```
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/olambo/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
```
## Apps I use

### [Karabiner-Elements](https://pqrs.org/osx/karabiner/)
I use Karabiner-Elements for key remapping. For instance, I remap my capslock
key to 
- <kbd>Esc</kbd> (when pressed and released) 
- <kbd>hyper</kbd> key (<kbd>shift</kbd>+<kbd>ctrl</kbd>+<kbd>option</kbd>+<kbd>command</kbd>). 

Some of the key, I remap
-  <hyp> h, j, k, l  -> <left>, <down>, <up>, <right>
-  <hyp> u, d        -> <pageup>, <pagedown>
-  <hyp> 9, 0        -> <c-a>, <c-e> (in macos gui apps, eg Safari)
-  <hyp> 9, 0        -> <home>, <end> (in iTerm2)
-  <cmd-c>           -> <c-a> (in iTerm2, copy from vim to system clipboard even from remote machines)
-  <hyp> [, ]        -> <shift,cmd,[ or ]> select next or previous tab
-  <hyp> return      -> <shift,cmd,return> iTerm2 expands pane to whole window
-  <hyp> n           -> <opt,cmd,down> iTerm2 select pane below (if no pane below, go to top)
-  <hyp> b           -> <opt,cmd,left> iTerm2 select pane left (if no pane left, go to far right)

### [Hammerspoon](https://www.hammerspoon.org)
I use hammerspoon to map <kbd>hyper</kbd> keys to open various applications and position windows


