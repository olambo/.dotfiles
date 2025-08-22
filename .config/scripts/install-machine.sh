mac install
# ==============================

# Xcode command line and homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# macOS terminal apps
term_apps=(
wget
git
neovim
httpie
fzf
ripgrep
trash
uv
ruff
tree
)
brew install ${term_apps[@]} 

# macOS cask apps
cask_apps=(
karabiner-elements
hammerspoon
alfred
vlc
warp
visual-studio-code
keyboardCleanTool
)
brew install --appdir="/Applications" ${cask_apps[@]}

# deprecate
# brew install cormacrelf/tap/dark-notify

# Remove brew cruft
brew cleanup

git clone https://github.com/softmoth/zsh-vim-mode ~/.config/zsh-vim-mode

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Follow new machine clone instructions at https://github.com/olambo/.dotfiles
dot remote set-url origin git@github.com:olambo/.dotfiles.git

# Set keyboard caps lock to control
# Set Finder settings you want

# open Neovim and run :PlugInstall

# Various installs to do
# Enpass - icloud sync login
# Alfred - key shortcut
# Neovim - PlugInstall
# Email - add account
# Pandan - in menu

# install JetBrains Mono and choose it for Warp at 14pt
# vscode install python python debugger and neovim. Check path for neovim 
# vscode install ruff and even better TOML
# vscode set movement via: defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# ==============================
#
# defaults write com.apple.dock autohide-time-modifier -float 0.1;killall Dock
