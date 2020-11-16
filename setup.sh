#!/bin/bash
export curr=$(dirname $(realpath $0))
export url="https://github.com/wulan17/zsh-config/raw/master"
export os=$(uname -o)
function select_distro(){
	echo "Select Your Operation System :"
	echo "	1. Ubuntu, Debian, Linux Mint
	2. Arch Linux, Manjaro"
	echo -n "Choose : "
	read distro
	echo ""
	echo "Installing zsh..."
	case "$distro" in
		1)
			sudo apt update
			sudo apt install curl zsh -y
			;;
		2)
			sudo pacman -Sy curl zsh
			;;
		*)
			exit
			;;
	esac
}
function select_antigen(){
	echo "Choose antigen type :"
	echo "	1. Stable
	2. Nightly"
	echo -n "Choose : "
	read antigen
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
}
function setup(){
	echo "Copying files..."
	if [ -z $(ls "$curr"/.zshrc) ];then
		curl -L "$url"/.antigenrc > ~/.antigenrc
		curl -L "$url"/.zshrc > ~/.zshrc
	else
		cp "$curr"/{.zshrc,.antigenrc} ~/
	fi
}

if [ $os == "Android" ];then
	echo "Installing zsh..."
	pkg update -y
	pkg install curl zsh debianutils -y
	select_antigen
	setup
	if [ ! -d ~/.termux ];then
		mkdir ~/.termux
	fi
	if [ -z $(ls "$curr"/termux.properties) ];then
		curl -L "$url"/termux.properties > .termux/termux.properties
	else
		cp "$curr"/termux.properties ~/.termux/termux.properties
	fi
	echo "Set default shell..."
	chsh -s zsh
	echo "Done"
	zsh
else
	select_distro
	select_antigen
	setup
	echo "Set default shell..."
	sudo chsh $(whoami) -s $(which zsh)
	echo "Done"
	zsh
fi
