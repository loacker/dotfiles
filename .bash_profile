# ~/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Manage the OpenSSH rsa key on login
eval `keychain --eval --nogui -Q -q id_rsa`

