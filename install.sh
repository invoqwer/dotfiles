#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

echo "WARNING: this will replace existing config files"
read -r -p "Press any key to continue."

# compton
ln -s "$HOME"/dotfiles/term/compton.conf "$HOME"/.config/compton.conf

# alacritty
ln -s "$HOME"/dotfiles/term/alacritty.yml "$HOME"/.config/alacritty/alacritty.yml

# .zshrc
rm "$HOME"/.zshrc
ln -s "$HOME"/dotfiles/term/.zshrc "$HOME"/.zshrc

# work alias
ln -s "$HOME"/dotfiles/term/git.zsh "$ZSH_CUSTOM/git.zsh"
ln -s "$HOME"/dotfiles/term/work.zsh "$ZSH_CUSTOM/work.zsh"

# i3
rm -r "$HOME"/.config/i3
ln -s "$HOME"/dotfiles/i3 "$HOME"/.config/i3

# scripts
ln -s "$HOME"/dotfiles/scripts "$HOME"/.config/scripts

# bg
mkdir -p "$HOME"/.config/bg

# TODO download bg photos from google drive 

# install shellcheck (for linting)
sudo apt install -y shellcheck