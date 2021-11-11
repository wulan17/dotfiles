if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  startx
  #dbus-update-activation-environment --systemd --all
fi

source ~/antigen.zsh
antigen init ~/.antigenrc

path+=("$HOME/.local/bin")
export PATH
trackers="https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt"
export trackers
alias aria2="aria2c --file-allocation=falloc -s16 -x16 --bt-tracker=""$trackers"
export GPG_TTY=$(tty)
