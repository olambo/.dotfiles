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

### Operations (example)
```
cd $HOME
dot add .zshrc.conf
dot commit -m "Add .zshrc.conf"
dot push
```
## New machine clone
To set up a new machine, clone the repo to a temporary directory. This is because you might have some default config files in your $HOME which will cause a normal clone to fail.
```
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/olambo/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
```
## Apps I use to modify keyboard mappings

### [Karabiner-Elements](https://pqrs.org/osx/karabiner/)
I use Karabiner-Elements for key remapping. For instance, I remap my capslock key
- <kbd>esc</kbd> when pressed and immediately released
- <kbd>hyp</kbd> key (<kbd>shift</kbd>+<kbd>ctrl</kbd>+<kbd>option</kbd>+<kbd>command</kbd>) 

Some of the keys, I remap are listed below.

```
<hyp> h, j, k, l -> <left>, <down>, <up>, <right> - vim like motions (all apps)
<hyp> u, d       -> <pageup>, <pagedown> - vim like motions (all apps)
<hyp> [, ]       -> <shift,cmd, [ or ]> next or previous tab (all apps)
<hyp> 9, 0       -> <c-a>, <c-e>  begining and end of line (gui apps, eg safari) 
<hyp> 9, 0       -> <home>, <end> begining and end of line (iterm2 and vim)
<hyp> ;, comma   -> <ctrl, j or k> vim-sneak label mode - I use the 's' key (vim)
<hyp> return     -> <shift,cmd,return> expands pane to whole iterm2 window (iTerm2) 
<hyp> n          -> <opt,cmd,down> select pane below (if no pane below, go to top) (iTerm2) 
<hyp> b          -> <opt,cmd,left> select pane left (if no pane left, go to far right) (iTerm2) 
<cmd-c>          -> <cmd-c><c-a> copy to system clipboard, even from remote machines (iTerm2 vim)
```
Vim can't directly map <kbd>hyp<kbd> keys. So I have Karabiner-Elements first map a <kbd>hyp<kbd> key to a key (or combination) that vim can recognize.
For instance, when I press <kbd>hyp-;<kbd> I have karabiner execute <kbd>ctrl-j<kbd>. This key is mapped to the vim's Sneak_s pluggin. Note: I've never used <kbd>ctrl-j<kbd> in Vim for anything. If you do, map to a key you don't use.

### [Hammerspoon](https://www.hammerspoon.org)
I use hammerspoon to set some <kbd>hyp</kbd> keys to open various applications and position windows

