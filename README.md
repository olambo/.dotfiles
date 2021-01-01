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
- <kbd>hyp</kbd> key (<kbd>shift</kbd>+<kbd>ctrl</kbd>+<kbd>option</kbd>+<kbd>command</kbd>) + normal key

Some of the keys, I remap are listed below.

```
<hyp> h j k l -> left, down, up, right. Vim like motions (all apps)
<hyp> u d     -> pageup, pagedown. Vim like motions (all apps)
<hyp> [ ]     -> next or previous tab (all apps)
<hyp> ( )     -> begining or end of line (all apps)
<hyp> ; ,     -> Vim-sneak label mode (Vim)
<hyp> return  -> expand pane (iTerm2) 
<hyp> n b     -> next vertical or horizontal pane (iTerm2) 
<cmd> c       -> copy to system clipboard from remote machine (iTerm2 Vim)
```
Vim can't directly map <kbd>hyp</kbd> keys. So I have Karabiner-Elements first map a <kbd>hyp</kbd> key to key(s) that Vim can recognize.
For instance, when I press <kbd>hyp-;</kbd>, I have karabiner execute <kbd>ctrl-x ctrl-j</kbd>. This key combination is mapped to the Vim Sneak_s pluggin. 
Note: I use the 's' key in Vim normal mode so I can't use Vim-sneaks suggestion of using that key.

### [Hammerspoon](https://www.hammerspoon.org)
I use hammerspoon to set some <kbd>hyp</kbd> keys to open various applications and position windows

