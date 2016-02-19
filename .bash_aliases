# My personal shell alias

# OS related
alias down='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'

# Music manager
alias ncmpcpp='[ -z $(cat ~/.mpd/pid 2> /dev/null) ] && mpd && ncmpcpp || ncmpcpp'
alias vimpc='[ -z $(`cat ~/.mpd/pid`) ] && mpd && vimpc || vimpc'

# Libvirt
alias vls='virsh list --all'
alias vstart='virsh start $1'
alias virtstart='sudo rc-service libvirt-guests start'
alias vstop='virsh destroy $1'
alias virtstop='sudo rc-service libvirt-guests stop'
alias vsave='virsh managedsave $1'

# Vagrant 
alias vghalt='vagrant halt'
alias vgup='vagrant up'
alias vgssh='vagrant ssh'
alias vgdestroy='vagrant destroy'

# wget
alias wd='wget -r --no-parent --reject "index.html*" $1'

# Term for SSH
alias ssh='TERM=xterm-color ssh'
