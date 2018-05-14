#!/bin/sh -c

. /etc/X11/xinit/xinitrc

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources #FROMBBCPLUGIN
