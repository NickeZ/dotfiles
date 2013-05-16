#!/bin/sh

exec xfce4-power-manager
eval `run_once.sh ssh-agent`
exec pidgin &
exec thunderbird &
exec nm-applet &

exec awesome
