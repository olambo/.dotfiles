# Dotfiles

Bare git repository setup for managing dotfiles without symlinks. Based on ideas from [this HN discussion](https://news.ycombinator.com/item?id=11070797) and [anandpiyer's dotfiles](https://github.com/anandpiyer/.dotfiles/tree/master/.dotfiles).

Files live in their natural locations (`~/.vimrc`, `~/.config/`, etc.) while git metadata is stored in `~/.dotfiles/`.

## New Machine Clone Setup

Clone to a temporary directory first to avoid conflicts with existing default configs:

```
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/olambo/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles

# The dot alias is already configured in .zshrc
# Just source it or restart your shell
source ~/.zshrc
```

## Usage

Use `dot` like git from anywhere in your home directory:

```
dot add .vimrc
dot commit -m "Update vim config"
dot push
dot status
```

## Key Mappings


### Karabiner Elements

- Caps Lock → Control/Esc (Karabiner-Elements)


### Hammerspoon

```
Global key remappings for consistent navigation:

Key Combination      Action                    Context
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Ctrl+Space           Application launcher     Global
Ctrl+J/K/L           Down/Up/Right nav        Global  
Ctrl+H               Left/Select left         Global
Ctrl+9/0             Beginning/End of line    Global
Ctrl+Return          Toggle pane size         VSCode
Ctrl+;               App switcher (Cmd+Tab)   Global
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

See `.hammerspoon/init.lua` for complete configuration.
