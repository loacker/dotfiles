# Create and access a directory
mkd() { /bin/mkdir -p $@; cd $@; }

# Manage  github repository
# Create a token with repo and delete permissions
# Set an include in the .gitconfig file and save the githun credential in the
# .gitconfig.ignored file (set the exclusion in the .gitignore)
# git config --global include.path ~/.dotfiles/.gitconfig.ignored
# git config --file ~/.dotfiles/.gitconfig.ignored github.user <username>
# git config --file ~/.dotfiles/.gitconfig.ignored github.token <token>
github_createrepo() { 
    USER=$(git config github.user)
    TOKEN=$(git config github.token)
    [[ $1 == '' ]] && echo "ERROR: Missing repository name" && return 130
    curl -u "${USER}:${TOKEN}" https://api.github.com/user/repos \
         -d '{"name":"'${1}'"}' > /dev/null 2>&1
}

github_deleterepo() {
    USER=$(git config github.user)
    TOKEN=$(git config github.token)
    [[ $1 == '' ]] && echo "ERROR: Missing repository name" && return 130
    curl -X DELETE -u "${USER}:${TOKEN}" \
        https://api.github.com/repos/${USER}/${1} > /dev/null 2>&1
}

# vim: set ts=8 sw=4 sts=4 tw=79 ff=unix ft=sh et ai :
