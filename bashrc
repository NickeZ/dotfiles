## Git prompt config
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
source $HOME/git/dotfiles/git-prompt.sh

## Bash config
HISTSIZE=5000
HISTFILESIZE=10000

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u \[\033[01;34m\]@ \[\033[01;35m\]\h\[\033[00m\] : \[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\n\$ '
unset color_prompt force_color_prompt

alias xil10_init=""
function xil10_init () {
. /opt/Xilinx/10.1/ISE/settings64.sh
. /opt/Xilinx/10.1/EDK/settings64.sh
export LD_PRELOAD=/opt/Xilinx/lib/libusb-driver.so
}

function xil13_init () {
. /opt/Xilinx/13.4/ISE_DS/settings64.sh
}

function xil14_init () {
local OPT=/home/niklas-sl/opt
XIL_CSE_PLUGIN_DIR=$HOME/.cse
. $OPT/Xilinx/14.4/ISE_DS/settings64.sh
}

function xil147_init () {
. /home/niklas/opt/Xilinx/14.7/ISE_DS/settings64.sh
}

alias update='sudo apt-get update && sudo apt-get dist-upgrade -y'
alias altera_init="export PATH=${PATH}:/home/niklas-sl/opt/altera/12.1/quartus/bin"
alias bc="bc -l"
alias grep='grep --exclude-dir=.svn --line-number --color=auto'
alias indentCosy="indent -linux -i2 -nut"
alias evnova="WINEPREFIX=$HOME/.wine_evnova wine start \"$HOME/.wine_evnova/drive_c/users/niklas/Start Menu/Programs/EV Nova/EV Nova.lnk\""

SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

# Base16 Shell
BASE16_SHELL="$HOME/git/dotfiles/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
