#!/usr/bin/env bash
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

# Set path to rustc/cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	case "$PATH" in
		*:"$HOME/bin":*)
			;;
		*)
			PATH="$HOME/bin:$PATH"
	esac
fi
if [ -d "$HOME/.local/bin" ] ; then
	case "$PATH" in
		*:"$HOME/.local/bin":*)
			;;
		*)
			PATH="$HOME/.local/bin:$PATH"
	esac
fi
if [ -d "$HOME/go/bin" ] ; then
	case "$PATH" in
		*:"$HOME/go/bin":*)
			;;
		*)
			PATH="$HOME/go/bin:$PATH"
	esac
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
