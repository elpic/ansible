#!/bin/bash -i

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo "Usage ./bin/dotfiles.sh"
	echo ""
	exit
fi

echo "Linking zshrc"
rm -rf ~/.zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

echo "Linking powerlevel 10k (zsh theme)"
rm -rf ~/.p10k.zsh
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

echo "Linking nvim"
rm -rf ~/.config/nvim
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim

echo "Linking asdf default versions"
rm -rf ~/.tool-versions
ln -s ~/.dotfiles/.tool-versions ~/.tool-versions

echo "Linking git config"
rm -rf ~/.gitconfig
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

rm -rf ~/.gitignore_global
ln -s ~/.dotfiles/.gitignore_global ~/.gitignore_global

echo "Removing tmux-sessionizer"
rm -rf /usr/local/bin/tmux-sessionizer
rm -rf /usr/local/bin/tmux-sessionizer-switcher.sh

echo "Linking sessionizer"
rm -rf /usr/local/bin/sessionizer
ln -s ~/.dotfiles/scripts/sessionizer/sessionizer /usr/local/bin/sessionizer

mkdir -p ~/.config/sessionizer

echo "Linking tmux files"
rm -rf ~/.tmux.conf
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "Linking cht.sh"
rm -rf /usr/local/bin/cht.sh
ln -s ~/.dotfiles/scripts/cht.sh /usr/local/bin/cht.sh
