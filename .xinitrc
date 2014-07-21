#!/bin/sh

xrdb -merge ${HOME}/.Xresources
xmodmap ${HOME}/.Xmodmap

${HOME}/bin/runonce "$(which xscreensaver) -no-splash"

urxvt -e screen &

conky -d

exec awesome
