#!/bin/bash
export curr=$(dirname $(realpath $0))
export url="https://github.com/wulan17/zsh-config/raw/master"
function install_zsh(){
	echo "Select Your Operation System :"
	echo "	1. Ubuntu, Debian, Linux Mint
	2. Arch Linux, Manjaro
	3. Termux"
	echo -n "Choose : "
	read os
	echo ""
	echo "Choose antigen type :"
	echo "	1. Stable
	2. Nightly"
	echo -n "Choose : "
	read antigen
	echo "Installing zsh..."
	case "$os" in
		1)
			sudo apt update
			sudo apt install curl zsh -y
			;;
		2)
			sudo pacman -Sy curl zsh
			;;
		3)
			pkg update -y
			pkg install curl zsh debianutils -y
			;;
		*)
			exit
			;;
	esac
	case "$antigen" in
		1)
			curl -L git.io/antigen > ~/antigen.zsh
			;;
		2)
			curl -L git.io/antigen-nightly > ~/antigen.zsh
			;;
		*)
			curl -L git.io/antigen > ~/antigen.zsh
			;;
	esac
	echo "Copying files..."
	if [ -e $(ls "$curr"/.zshrc) ];then
		cp "$curr"/{.zshrc,.antigenrc} ~/
	else
		curl -L "$url"/.antigenrc > ~/.antigenrc
		curl -L "$url"/.zshrc > ~/.zshrc
	fi
	echo "Set default shell..."
	sudo chsh $(whoami) -s $(which zsh)
	echo "Done"
	zsh
}
install_zsh