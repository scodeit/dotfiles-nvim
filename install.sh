#!/usr/bin/env bash
set -e

REPO="https://github.com/scodeit/dotfiles-nvim.git"
NVIM_CONFIG="$HOME/.config/nvim"

echo "==> Installing dependencies..."

if command -v apt-get &>/dev/null; then
  sudo apt-get update -qq
  sudo apt-get install -y git curl unzip ripgrep fd-find nodejs npm
  # fd-find installs as 'fdfind' on ubuntu, symlink it
  [ ! -f /usr/local/bin/fd ] && sudo ln -sf "$(which fdfind)" /usr/local/bin/fd 2>/dev/null || true

elif command -v dnf &>/dev/null; then
  sudo dnf install -y git curl unzip ripgrep fd-find nodejs npm

elif command -v pacman &>/dev/null; then
  sudo pacman -Sy --noconfirm git curl unzip ripgrep fd nodejs npm

else
  echo "Unsupported package manager. Install manually: git curl ripgrep fd nodejs"
fi

echo "==> Installing Ghostty..."
if command -v flatpak &>/dev/null; then
  flatpak install -y flathub com.mitchellh.ghostty 2>/dev/null || true
elif command -v pacman &>/dev/null; then
  sudo pacman -Sy --noconfirm ghostty 2>/dev/null || yay -S --noconfirm ghostty 2>/dev/null || true
else
  echo "    Install Ghostty manually: https://ghostty.org/download"
fi

echo "==> Installing Neovim (latest)..."
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
curl -sL "$NVIM_URL" | sudo tar -xz -C /usr/local --strip-components=1

echo "==> Setting up Neovim config..."
if [ -d "$NVIM_CONFIG" ]; then
  echo "    Backing up existing config to ~/.config/nvim.bak"
  mv "$NVIM_CONFIG" "$HOME/.config/nvim.bak"
fi
git clone "$REPO" "$NVIM_CONFIG"

echo "==> Installing plugins (headless)..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo ""
echo "Done! Run: nvim"
echo "First launch will finish installing LSPs via Mason."
