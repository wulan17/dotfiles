## Images

![](https://raw.githubusercontent.com/wulan17/dotfiles/artix-lxqt/imgs/desktop.png)
![](https://raw.githubusercontent.com/wulan17/dotfiles/artix-lxqt/imgs/pcmanfm.png)
  
## INFO
* DE : LXQT  
* WM : Openbox  
* Compositor : picom (tryone)  
* Terminal : Gnome-terminal
* Shell : zsh  
* Zsh Plugins Manager : antigen  
* QT style : gtk  
* GTK theme : Arc Dark  
* LXQT theme : Arc Dark  
* Openbox Theme : Arcbox  
* Zsh theme : eastwood  
* Zsh Plugins : git, command-not-found, docker, zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting  
  
## DEPENDENCIES  
* arc-gtk-theme  
* [Arcbox](https://www.box-look.org/p/1017425/) (Openbox Theme)  
* curl  
* dbus  
* dbus-openrc  
* git  
* gnome-terminal-transparency
* lxqt  
* lxqt-arc-dark-theme-git  
* papirus-icon-theme  
* picom-tryone-git  
* pipewire  
* pipewire-pulse  
* pipewire-media-session  
* qt5-styleplugins  
* [yay](https://github.com/Jguer/yay)  
* zsh  
  
## HOW TO  
### A. Install git  
```
sudo pacman -Syyu  
sudo pacman -S git  
```  
### B. Install yay : [Click Here](https://github.com/Jguer/yay#Installation)  
### C. Install Config  
```
git clone https://github.com/wulan17/dotfiles.git  
cd dotfiles  
bash setup.sh  
```  

### D. Install Arcbox
1. Download and extract [Arcbox theme](https://www.box-look.org/p/1017425/)
2. Open Openbox Settings
3. Select Create a Theme archive (.obt)...
4. go to /path/to/Arcbox and click Open
5. Select Install a new theme...
6. go to your HOME folder
7. select Arcbox.obt then click Open
8. Select Arcbox from theme list
