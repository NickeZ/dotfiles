#!/bin/bash
# shellcheck disable=SC2034
## Git prompt config
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
. $HOME/.config/git/git-prompt.sh

## Bash config
HISTSIZE=5000
HISTFILESIZE=10000

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u \[\033[01;34m\]@ \[\033[01;35m\]\h\[\033[00m\] : \[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\n\$ '
unset color_prompt force_color_prompt

alias bc="bc -l"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock.$(hostname)
fi

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi

# Base16 Shell
#BASE16_SHELL="$HOME/git/dotfiles/vendor/base16-shell/scripts/base16-solarized-dark.sh"
#BASE16_SHELL="$HOME/git/dotfiles/vendor/base16-shell/scripts/base16-solarized-light.sh"
#[[ "$-" == *i* ]] && [[ -s $BASE16_SHELL ]] && . "$BASE16_SHELL"

alias docker-rmexited="sudo sh -c 'docker ps -a | /bin/grep Exit | cut -d \" \" -f 1 | xargs docker rm'"

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/ripgreprc

PATH=/home/niklas/.daml/bin:$PATH
