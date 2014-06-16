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
[[ -d ~/.gem ]] && LOCAL_RUBYPATH=$(ls -d ~/.gem/ruby/*/bin)
export PATH=$PATH:~/bin:~/.local/bin:${LOCAL_RUBYPATH//[[:space:]]/:}

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

# Set dircolors
eval `dircolors ~/.dircolors`

# Color escape sequence
C_RESET='\033[0m'
C_WHITE='\033[0;1m'
C_BLACK='\033[0;30m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_PURPLE='\033[0;35m'
C_CYAN='\033[0;36m'
C_GRAY='\033[0;37m'

C_BOLD_BLACK='\033[1;30m'
C_BOLD_RED='\033[1;31m'
C_BOLD_GREEN='\033[1;32m'
C_BOLD_YELLOW='\033[1;33m'
C_BOLD_BLUE='\033[1;34m'
C_BOLD_PURPLE='\033[1;35m'
C_BOLD_CYAN='\033[1;36m'
C_BOLD_GRAY='\033[1;37m'

# Set Colorful PS1
# Attribute codes: 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes: 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Define an alias for the color - remember to escape with \[ at begin and \] at the end or 
# with the equivalent octal code \001 and \002, the octal code \033 can be substituted by '\e'.
# If you don't escape the prompt break the newline like inserting a carriage return 

PS1="\[${C_BOLD_GREEN}\]\u\[${C_WHITE}\]@\[${C_BOLD_RED}\]\h\[${C_WHITE}\]:\[${C_BOLD_CYAN}\]\w\[${C_BOLD_YELLOW}\] \$\[${C_RESET}\] "

# Extend PS1 with colorful/dynamic git branch
# Escape the start and the end
# N.B if I use the \[ with printf doesn't work, but I don't know why
es="\001"
ee="\002"
C_UL_RED='\033[4;31m'

_git_ps1 () {
    # Check if CWD is a git repository
    git branch > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        git status 2> /dev/null | grep -Ei 'nothing to commit' > /dev/null 2>&1
        if [ "$?" -eq "0" ]; then
            printf "%b" "${es}${C_BOLD_YELLOW}${ee}(`git branch 2> /dev/null \
                   | sed -e '/^\s\+/d' -e 's/^*\s//g'`)${es}${C_WHITE}${ee}:${es}${C_RESET}${ee}"
        else 
            printf "%b" "${es}${C_UL_RED}${ee}(`git branch 2> /dev/null \
                    | sed -e '/^\s\+/d' -e 's/^*\s//g'`)${es}${C_WHITE}${ee}:${es}${C_RESET}${ee}"
        fi
    fi
}

[[ "$-" != "*i*" ]] && PS1='$(_git_ps1)'$PS1

# Alias definition
alias virls='virsh list --all'
alias down='sudo shutdown -h now'

# Virtualenvwrapper config
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/projects
source `which virtualenvwrapper.sh`
#export VIRTUALENVWRAPPER_SCRIPT=`which virtualenvwrapper.sh`
#source `which virtualenvwrapper_lazy.sh`

