# My personal shell alias

# OS related
alias down='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'

# Music manager
alias ncmpcpp='[ -z $(pgrep mpd) ] && mpd && ncmpcpp || ncmpcpp'
alias vimpc='[ -z $(pgrep mpd) ] && mpd && vimpc || vimpc'

# Libvirt
alias vls='virsh list --all'
alias vstart='virsh start $1'
alias virtstart='sudo rc-service libvirtd start && sudo rc-service libvirt-guests start'
alias vstop='virsh destroy $1'
alias virtstop='sudo rc-service libvirt-guests stop && sudo rc-service libvirtd stop'
alias vsave='virsh managedsave $1'

# Vagrant 
alias vghalt='vagrant halt'
alias vgup='vagrant up'
alias vgssh='vagrant ssh'
alias vgdestroy='vagrant destroy'
alias vgsusp='vagrant suspend'
alias vgrel='vagrant reload'

# wget
alias wd='wget -r --no-parent --reject "index.html*" $1'

# Term for SSH
alias ssh='TERM=xterm-color ssh'

# Colored output for less
alias ls='ls --color=always' 
alias grep='grep --color=always' 

# Webcam test
alias wcam='vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio2"'
