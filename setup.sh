#!/bin/bash
export curr=$(dirname $(realpath $0))
export url="https://github.com/wulan17/zsh-config/raw/master"
export os=$(uname -o)

antigen="stable"

while getopts ":hn" opt; do
    case $opt in
        h)
            echo "Available flags: -h, -n
    -h: Print this help message
    -n: Install antigen nightly"
            exit 0
            ;;
        n)
            antigen="nightly"
            ;;
    esac
done

function detect_sudo(){
	if [ "$EUID" -ne 0 ]; then
		if [ -x "$(command -v doas)" ];then
			SUDO="doas"
		elif [ -x "$(command -v sudo)" ];then
			SUDO="sudo"
		else
			echo "Please install sudo or doas"
			exit
		fi
	else
		SUDO=""
	fi
}

function install_zsh(){
	echo "Detecting package manager.."
	if [ -x "$(command -v apt)" ];then
		distro=1
	elif [ -x "$(command -v pacman)" ];then
		distro=2
	else
		echo "Your distro not supported"
		exit
	fi
	case "$distro" in
		1)
			echo "Debian based distribution detected"
			echo "Installing zsh..."
			if [ "$SUDO" != "" ];then
				"$SUDO" apt update > /dev/null
				"$SUDO" apt install curl zsh aria2 -y > /dev/null
			else
				apt update > /dev/null
				apt install curl zsh aria2 -y > /dev/null
			fi
			;;
		2)
			echo "Arch linux based distribution detected"
			echo "Installing zsh..."
			if [ "$SUDO" != "" ];then
				"$SUDO" pacman -Sy --noconfirm --needed curl zsh aria2 > /dev/null
			else
				pacman -Sy --noconfirm curl zsh aria2 > /dev/null
			fi
			;;
		*)
			echo "Your distribution is not supported by this script!"
			exit
			;;
	esac
}

function download_antigen(){
	case "$antigen" in
		"stable")
			echo "Downloading antigen $antigen..."
			curl -s -L git.io/antigen > ~/.antigen.zsh
			;;
		"nightly")
			echo "Downloading antigen $antigen..."
			curl -s -L git.io/antigen-nightly > ~/.antigen.zsh
			;;
	esac
}

function setup(){
	echo "Copying files..."
	if test -f "$curl"/.zshrc;then
		cp "$curr"/.zshrc ~/
		cp "$curr"/.antigenrc ~/
		cp -r .themes ~/
	else
		curl -s -L "$url"/.antigenrc > ~/.antigenrc
		curl -s -L "$url"/.zshrc > ~/.zshrc
		mkdir -p ~/.themes
		curl -s -L "$url"/.themes/wulan17.zsh-theme > ~/.themes/wulan17.zsh-theme
	fi
}

if [ $os == "Android" ];then
	echo "Installing zsh..."
	if [ -x "$(command -v pacman)" ];then
		echo "Updating system..."
		pacman -Syu --noconfirm > /dev/null
		echo "Installing zsh..."
		pacman -S --needed --noconfirm curl zsh aria2 > /dev/null
	else
		echo "Updating system..."
		pkg update -y > /dev/null
		pkg upgrade -y > /dev/null
		echo "Installing zsh..."
		pkg install curl zsh debianutils aria2 -y > /dev/null
	fi
	download_antigen
	setup
	mkdir -p ~/.termux
	if test -f "$curr"/termux.properties;then
		cp "$curr"/termux.properties ~/.termux/termux.properties
	else
		curl -L "$url"/termux.properties > ~/.termux/termux.properties
	fi
	echo "Set default shell..."
	chsh -s zsh
	echo "Done"
	zsh
else
	detect_sudo
	install_zsh
	download_antigen
	setup
	echo "Set default shell..."
	if [ "$SUDO" != "" ];then
		"$SUDO" chsh $(whoami) -s $(which zsh)
	else
		chsh $(whoami) -s $(which zsh)
	fi
	echo "Done"
	zsh
fi
