# Create and access a directory
mkd() { /bin/mkdir -p $@; cd $@; }

# Manage  github repository
# Create a token with repo and delete permissions
# set in the git config with the following commands:
# git config --global github.user <username>
# git config --global github.token <token>
# Or better create a separated file like .gitconfig.ignored and include
# in the .gitconfig like the following example and move the github
# configuration in this file.
#[include]
#	path = ~/.gitconfig.ignored
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
