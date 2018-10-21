#!/usr/bin/env bash

if [ "$0" = "/etc/gdm3/Xsession" -a "$DESKTOP_SESSION" = "i3" ]; then
	# dbus-update-activation-environment --systemd DISPLAY
	export $(gnome-keyring-daemon -s)
	xrandr --dpi eDP-1

	# Set path to rustc/cargo
	[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

	export TERMINAL=alacritty
	export EDITOR=vim

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
fi
