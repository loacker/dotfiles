#!/bin/sh

xrdb -merge ${HOME}/.Xresources
xmodmap ${HOME}/.Xmodmap

exec qtile

${HOME}/bin/runonce "$(which xscreensaver) -no-splash"

/usr/bin/urxvt -e screen -R -D &
/usr/bin/firefox-bin &
/usr/bin/chromium &
/opt/bin/skype &
/usr/bin/thunderbird-bin &
/usr/bin/redshift-gtk -l 52.38:4.83 -t 5700:3600 -g 0.8 -m randr -v &

conky -d
