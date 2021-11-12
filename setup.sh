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
function install_depend(){
	echo "Installing dependencies..."
	sudo pacman --no-confirm -Sy curl zsh pipewire pipewire-pulse pipewire-media-session lxqt qt5-styleplugins dbus dbus-openrc arc-gtk-theme
	yay -S --answerdiff N --answerclean Y --removemake --noconfirm picom-tryone-git lxqt-arc-dark-theme-git papirus-icon-theme gnome-terminal-transparency
}
function setup(){
	echo "Copying files..."
	cp "$curr"/{.zshrc,.antigenrc} ~/
	if [ -z $(ls ~/.xinitrc) ];then
			cp "$curr"/.xinitrc > ~/
	else
		mv ~/.xinitrc ~/.xinitrc.bak
		cp "$curr"/.xinitrc > ~/
	fi
	cp -r "$curr"/config ~/
	sed -i "s/wulan17/$(whoami)/g" ~/.config/lxqt/panel.conf
}
install_depend
select_antigen
setup
echo "Set default shell..."
sudo chsh $(whoami) -s $(which zsh)
echo "Done"
zsh
