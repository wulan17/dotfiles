# Based on oh-my-zsh/eastwood
# RVM settings
if [[ -s ~/.rvm/scripts/rvm ]] ; then
  RPS1="%{$fg[yellow]%}rvm:%{$reset_color%}%{$fg[red]%}\$(~/.rvm/bin/rvm-prompt)%{$reset_color%} $EPS1"
else
  if which rbenv &> /dev/null; then
    RPS1="%{$fg[yellow]%}rbenv:%{$reset_color%}%{$fg[red]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$reset_color%} $EPS1"
  fi
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)%{$fg[green]%}$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX%{$reset_color%}"
  fi
}

uid=$(id -u)
if [ "$uid" -eq 0 ]; then
  user_prefix="%{$fg[red]%}[$(id -un)]%{$reset_color%}#"
else
  user_prefix="%{$fg[green]%}[$(id -un)]%{$reset_color%}$"
fi

NEWLINE=$'\n'

PROMPT='%{$fg[cyan]%}[$(hostname):%~% ]%{$reset_color%}$(git_custom_status)${NEWLINE}%B$user_prefix%b '
