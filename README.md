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
key to both <kbd>Esc</kbd> (when pressed and released) and 
<kbd>hyper</kbd> key (<kbd>shift</kbd>+<kbd>ctrl</kbd>+<kbd>option</kbd>+<kbd>command</kbd>). 

### [Hammerspoon](https://www.hammerspoon.org)
I use hammerspoon to map <kbd>hyper</kbd> keys to open various applications and position windows
