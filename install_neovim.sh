#!/bin/sh

set -e  # Exit immediately if a command exits with a non-zero status

# Prompt for sudo password upfront
#sudo -v
# Keep-alive: update existing `sudo` time stamp until the script finishes
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Download Neovim AppImage
echo "Downloading Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

# Add Neovim to PATH if not already present
if ! grep -q '/opt/nvim' ~/.bashrc; then
    echo 'export PATH="$PATH:/opt/nvim"' >> ~/.bashrc
    export PATH="$PATH:/opt/nvim"
    echo "Neovim added to PATH."
fi

# Set up Neovim config
echo "Setting up Neovim config directory..."
mkdir -p ~/.config/nvim
ln -sf init.vim ~/.config/nvim/init.vim
echo "init.vim linked to config."


# Install vim-plug for Neovim
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Prompt for Neovide installation
read -p "Do you want to install Neovide (Neovim GUI)? (y/n): " INSTALL_NEOVIDE
if echo "$INSTALL_NEOVIDE" | grep -qi "^y$"; then
    echo "Installing Neovide dependencies..."
    sudo apt update
    sudo apt install -y curl \
        gnupg ca-certificates git \
        gcc-multilib g++-multilib cmake libssl-dev pkg-config \
        libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
        libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
        libxcursor-dev

    # Install Rust
    echo "Installing Rust..."
    if ! command -v rustup &> /dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh -s -- -y
        . "$HOME/.cargo/env"
    else
        echo "Rust is already installed."
    fi

    # Install Neovide
    echo "Installing Neovide..."
    cargo install --git https://github.com/neovide/neovide

    echo "Neovide installation complete."
else
    echo "Neovide installation skipped."
fi

echo "Neovim installation complete!"

