# My personal shell alias

# OS related
alias down='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'

# Music manager
alias ncmpcpp='[ -z $(cat ~/.mpd/pid 2> /dev/null) ] && mpd && ncmpcpp || ncmpcpp'
alias vimpc='[ -z $(`cat ~/.mpd/pid`) ] && mpd && vimpc || vimpc'

# Libvirt
alias virls='virsh list --all'

# Vagrant 
alias vhalt='vagrant halt'
# Credits james http://bit.ly/1IvzbMS
alias vp='vagrant provision'
alias vup='vagrant up'
alias vssh='vagrant ssh'
alias vdestroy='vagrant destroy'

