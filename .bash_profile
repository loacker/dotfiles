# ~/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Manage screen check on startup
#[ `screen -ls |cut -d "." -f 2|grep work |awk '{print $1}'|wc -l` = 0 ] && `/usr/bin/screen -S work -s bash -T vt100 -t local -O`

