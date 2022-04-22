#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

echo "WARNING: this will replace existing config files"
read -r -p "Press any key to continue."

# compton
ln -s "$HOME"/dotfiles/term/compton.conf "$HOME"/.config/compton.conf

# .zshrc
rm "$HOME"/.zshrc
ln -s "$HOME"/dotfiles/term/.zshrc "$HOME"/.zshrc

# i3
rm -r "$HOME"/.config/i3
ln -s "$HOME"/dotfiles/i3 "$HOME"/.config/i3

# scripts
ln -s "$HOME"/dotfiles/scripts "$HOME"/.config/scripts
chmod 755 "$HOME"/.config/scripts/*

# bg
mkdir -p "$HOME"/.config/bg

# TODO download bg photos from google drive 

# install shellcheck (for linting)
sudo apt install -y shellcheck