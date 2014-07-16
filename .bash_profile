# ~/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Manage the OpenSSH rsa key on login
if [ "$EUID" != "0" ] || [ "$USER" != "root" ]; then
    [[ -f `which keychain` ]] > /dev/null 2>&1
    if [[ $? == 0 ]]; then
        eval `keychain --eval --nogui -Q -q id_rsa`
    fi
fi

