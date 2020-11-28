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
		if [ -z $(ls ~/.xinitrc) ];then
			curl -L "$url"/.xinitrc > ~/.xinitrc
		else
			mv ~/.xinitrc ~/.xinitrc.bak
			curl -L "$url"/.xinitrc > ~/.xinitrc
		fi
		if [ -z $(ls ~/.devilspie) ];then
			mkdir ~/.devilspie
			curl -L "$url"/opacity.ds > ~/.devilspie/opacity.ds
		else
			curl -L "$url"/opacity.ds > ~/.devilspie/opacity.ds
		fi
	else
		cp "$curr"/{.zshrc,.antigenrc} ~/
		if [ -z $(ls ~/.xinitrc) ];then
			cp "$curr"/.xinitrc > ~/
		else
			mv ~/.xinitrc ~/.xinitrc.bak
			cp "$curr"/.xinitrc > ~/
		fi
		if [ -z $(ls ~/.devilspie) ];then
			mkdir ~/.devilspie
			cp "$curr"/opacity.ds ~/.devilspie/
		else
			cp "$curr"/opacity.ds ~/.devilspie/
		fi
	fi
}
yay -S transset-df
sudo pacman -Sy curl zsh xcompmgr devilspie
select_antigen
setup
echo "Set default shell..."
sudo chsh $(whoami) -s $(which zsh)
echo "Done"
zsh
