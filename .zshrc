path+=("$HOME/.local/bin")
export PATH
export GPG_TTY=$(tty)
source ~/.antigen.zsh
antigen init ~/.antigenrc
trackers="https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt"
export trackers
alias aria2="aria2c --file-allocation=falloc -s16 -x16 --bt-tracker=""$trackers"
