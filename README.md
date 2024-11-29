# Keep dotfiles in git without symlinks.

This arrangement of dotfiles is based on ideas from [here](https://news.ycombinator.com/item?id=11070797) and [here](https://github.com/anandpiyer/.dotfiles/tree/master/.dotfiles). 
The idea is to keep all the dotfiles in their original locations.

## New machine clone
To set up a new machine, clone the repo to a temporary directory. 
This is because you might have some default config files in your $HOME which will cause a normal clone to fail.
```
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/olambo/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
```

## First time setup (not clone)
```
git init --bare $HOME/.dotfiles
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot remote add origin git@github.com:olambo/.dotfiles.git
```
You'll need to change the remote URL to your git repo. You should also add the `dot` alias command to your `.zshrc`. 
Now, you can use the `dot` command to do git operation from anywhere in your $HOME directory:

### Operations (example)
```
cd $HOME
dot add .zshrc.conf
dot commit -m "Add .zshrc.conf"
dot push
```
## Apps used to modify keyboard mappings

### Macos
Change capslock to be control key

### [Hammerspoon](https://www.hammerspoon.org)
- <kbd>esc</kbd> when control pressed and immediately released

Some of the keys, remaped are listed below.

```
<control> j k l    -> down, up, right (all apps)
<control> h        -> select left (all apps)
<control> ( )      -> begining or end of line (all apps)
<control> y        -> copy to system clipboard from remote machine (Vim like app scenario)
<control> return   -> expand/contract pane (vscode, intellij) 
<control> spacebar -> pop list to select common applications via hotkey (all apps)
```

