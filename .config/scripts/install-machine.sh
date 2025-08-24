#!/bin/bash
# macOS Machine Setup Script
set -e  # Exit on any error

echo "🍎 Starting macOS machine setup..."

# ==============================
# Core Development Tools
# ==============================
echo "📦 Installing Xcode command line tools..."
xcode-select --install || echo "Xcode tools already installed"

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Terminal applications
echo "⚙️  Installing terminal applications..."
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
    borgmatic
    starship
)
brew install "${term_apps[@]}"

# GUI applications
echo "🖥️  Installing GUI applications..."
cask_apps=(
    karabiner-elements
    hammerspoon
    alfred
    vlc
    warp
    visual-studio-code
    keyboardCleanTool
)
brew install --cask "${cask_apps[@]}"

# Clean up Homebrew
echo "🧹 Cleaning up Homebrew..."
brew cleanup

# ==============================
# Configuration Setup
# ==============================
echo "⚡ Setting up shell and editor configurations..."

# Neovim plugin manager
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ==============================
# Dotfiles Setup
# ==============================
echo "📁 Setting up dotfiles..."
# Note: Run this part manually or adjust if running from existing dotfiles
# git clone --bare git@github.com:olambo/.dotfiles.git $HOME/.dotfiles
# dot checkout
dot remote set-url origin git@github.com:olambo/.dotfiles.git

# Copy configuration templates
if [ -f ~/.config/borgmatic/config.yaml.template ]; then
    cp ~/.config/borgmatic/config.yaml.template ~/.config/borgmatic/config.yaml
    echo "⚠️  Don't forget to edit ~/.config/borgmatic/config.yaml with your encryption key"
fi

# ==============================
# System Preferences
# ==============================
echo "⚙️  Setting system preferences..."

# Faster dock autohide
defaults write com.apple.dock autohide-time-modifier -float 0.1
killall Dock

# Faster key repeat rates (great for Vim users)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable automatic spelling correction (interferes with coding/terminal work)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable key repeat for VSCode vim mode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

echo "✅ Core installation complete!"
echo ""
echo "🔧 Manual setup remaining:"
echo "   • Set Caps Lock to Control in System Preferences"
echo "   • Configure Finder preferences"
echo "   • Open Neovim and run :PlugInstall"
echo "   • Install and configure Enpass (iCloud sync)"
echo "   • Set Alfred keyboard shortcut"
echo "   • Configure email accounts"
echo "   • Install JetBrains Mono font for Warp (14pt)"
echo "   • Install VSCode extensions:"
echo "     - Python, Python Debugger, Neovim"
echo "     - Ruff, Even Better TOML"
# Configure Warp terminal
echo "Remember to manually set Warp settings:"
echo "  - Go to Settings > Features > Editor"
echo "  - Enable 'Tab key behavior' for autosuggestions"
echo "  - (This makes Tab accept full completion instead of partial)"
echo ""
echo "🎉 Setup script finished!"
