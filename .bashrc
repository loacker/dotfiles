# ~/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# User specific PATH variables
export PATH=$PATH:~/bin:~/bin/calibre:~/.gem/ruby/1.8/bin

# LIBVIRT Default URI
export LIBVIRT_DEFAULT_URI=qemu:///system

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# don't put duplicate lines in the history - ignoredups and ignorespace
# and erase duplicates
HISTCONTROL="ignoreboth:erasedups"

# set the number of commands to remember in the history (default 500) 
# for other see the man page bash(1)
HISTSIZE=10000
#HISTFILESIZE=20000
#HISTFILE=~/.history
#HISTTIMEFORMAT="[%F %T] "
#HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S

# append to the history file, don't overwrite it
shopt -s histappend

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Disable xon/xoff (^]+s) for use the forward-seach-history (emacs shell mode)
# feature or change the key bindings to use ^]+t
stty -ixon
#bind "\C-t":forward-search-history

# Alias definition
alias vless='/usr/share/vim/vim??/macros/less.sh'
alias ls='ls --color=always'
alias grep='grep --colour=always'
alias egrep='egrep --colour=always'
alias fgrep='fgrep --colour=always'
alias virls='virsh list --all'
alias down='sudo shutdown -h now'

# Color escape sequence

C_DEFAULT='\033[0m'
C_BLACK='\033[0;30m'
C_GRAY='\033[1;30m'
C_RED='\033[0;31m'
C_LIGHTRED='\033[1;31m'
C_GREEN='\033[0;32m'
C_LIGHTGREEN='\033[1;32m'
C_BROWN='\033[0;33m'
C_YELLOW='\033[1;33m'
C_BLUE='\033[0;34m'
C_LIGHTBLUE='\033[1;34m'
C_PURPLE='\033[0;35m'
C_PINK='\033[1;35m'
C_CYAN='\033[0;36m'
C_LIGHTCYAN='\033[1;36m'
C_LIGHTGRAY='\033[0;37m'
C_WHITE='\033[1;37m'

# Set Colorful PS1
# Attribute codes: 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes: 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Define an alias for the color - remember to escape with \[ at begin and \] at the end or 
# with the equivalent octal code \001 and \002, the octal code \033 can be substituted by '\e'.
# If you don't escape the prompt break the newline like inserting a carriage return 

#PS1='\[\033[01;32m\]\u\[\033[01;37m\]@\[\033[01;31m\]\h\[\033[01;37m\]:\[\033[01;36m\]\w\[\033[01;33m\] \$\[\033[00m\] '

PS1='\[\e[1;32m\]\u\[\e[1;37m\]@\[\e[1;31m\]\h\[\e[1;37m\]:\[\e[1;36m\]\w\[\e[1;33m\] \$\[\e[0m\] '
#PS1="\[${C_LIGHTGREEN}\]\u\[${C_WHITE}\]@\[${C_LIGHTRED}\]\h\[${C_WHITE}\]:\[${C_LIGHTCYAN}\]\w\[${C_YELLOW}\] \[\$${C_DEFAULT}\] "

# Extend PS1 with colorful/dynamic git branch
RST="\033[00m"
BY="\033[01;33m"
BW="\033[01;37m"
UR="\033[04;31m"
es="\001"
ee="\002"

_git_ps1 () {
    # Check if CWD is a git repository
    git branch > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        git status 2> /dev/null | grep -Ei 'nothing to commit' > /dev/null 2>&1
        if [ "$?" -eq "0" ]; then
            #printf "%b" "\001\033[01;33m\002(`git branch 2> /dev/null | sed -e '/^\s\+/d' -e 's/^*\s//g'`)\001\033[01;37m\002:\001\033[0m\002"
            printf "%b" "${es}${BY}${ee}(`git branch 2> /dev/null | sed -e '/^\s\+/d' -e 's/^*\s//g'`)${es}${BW}${ee}:${es}${RST}${ee}"
        else 
            #printf "%b" "\001\033[04;31m\002(`git branch 2> /dev/null | sed -e '/^\s\+/d' -e 's/^*\s//g'`)\001\033[0m\002\001\033[01;37m\002:\001\033[0m\002"
            printf "%b" "${es}${UR}${ee}(`git branch 2> /dev/null | sed -e '/^\s\+/d' -e 's/^*\s//g'`)${es}${BW}${ee}:${es}${RST}${ee}"
        fi
    fi
}

[[ "$-" != "*i*" ]] && PS1='$(_git_ps1)'$PS1
#PS1='$(_git_ps1 "%s")'$PS1

# Virtualenvwrapper config
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/projects
source /usr/bin/virtualenvwrapper.sh
#export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
#source /usr/bin/virtualenvwrapper_lazy.sh

