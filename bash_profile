# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# if NX is installed, add that
if [ -d "/usr/NX/bin" ] ; then
	PATH="/usr/NX/bin:$PATH"
fi

# if EPICS is installed, add that
if [ -d "/usr/local/epics/base/bin/linux-x86_64" ] ; then
	export EPICS_HOST_ARCH="linux-x86_64"
	PATH="/usr/local/epics/base/bin/${EPICS_HOST_ARCH}:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Allow locally installed libraries to be loaded.
if [ -z "$LD_LIBRARY_PATH" ] ; then
	export LD_LIBRARY_PATH=/usr/local/lib
else 
	export LD_LIBRARY_PATH+=:/usr/local/lib
fi

# Set locale stuff
#export LC_ALL="en_US.utf8"
export LC_TIME="sv_SE.utf8"
export LC_NUMERIC="sv_SE.utf8"
export LC_MONETARY="sv_SE.utf8"
export LC_MEASUREMENT="sv_SE.utf8"
export LC_PAPER="sv_SE.utf8"
export LC_COLLATE="sv_SE.utf8"

# Add scrolling in git diff
export LESS=RS

# Vim is the standard editor
export EDITOR=vim

# vim: set ft=.bashrc

#export EPICS_ENV_PATH=/opt/epics/modules/environment/niklasclaesson/3.14.12.5/bin/centos7-x86_64
#export PATH=$EPICS_ENV_PATH:$PATH

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
