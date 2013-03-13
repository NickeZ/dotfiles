HISTSIZE=5000
HISTFILESIZE=10000
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")\$ '
unset color_prompt force_color_prompt

. /home/niklas/git/dotfiles/git-prompt.sh
alias xil10_init=". /opt/Xilinx/10.1/ISE/settings64.sh;
. /opt/Xilinx/10.1/EDK/settings64.sh
export LD_PRELOAD=/opt/Xilinx/lib/libusb-driver.so"
function xil13_init () {
    . /opt/Xilinx/13.4/ISE_DS/settings64.sh
}
function xil14_init () {
    local OPT=/home/niklas-sl/opt
    XIL_CSE_PLUGIN_DIR=$HOME/.cse
    . $OPT/Xilinx/14.4/ISE_DS/settings64.sh
    XILINX=$OPT/Xilinx/14.4/ISE_DS
}

alias update='sudo apt-get update && sudo apt-get upgrade -y'

export LD_LIBRARY_PATH=/usr/local/lib

export EDITOR=vim

#export LC_ALL="en_US.utf8"
export LC_TIME="sv_SE.utf8"
export LC_NUMERIC="sv_SE.utf8"
export LC_MONETARY="sv_SE.utf8"
export LC_MEASUREMENT="sv_SE.utf8"

alias altera_init="export PATH=${PATH}:/home/niklas-sl/opt/altera/12.1/quartus/bin"
