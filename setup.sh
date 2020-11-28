#!/bin/bash
export curr=$(dirname $(realpath $0))
export url="https://github.com/wulan17/zsh-config/raw/master"

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
sudo pacman -Sy curl zsh
select_antigen
setup
echo "Set default shell..."
sudo chsh $(whoami) -s $(which zsh)
echo "Done"
zsh
