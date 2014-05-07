#!/bin/sh

xrdb -load $HOME/.Xresources

xmodmap ~/.Xmodmap

~/bin/runonce "$(which xscreensaver) -no-splash"

urxvt &

~/bin/runonce "screen -S work"
