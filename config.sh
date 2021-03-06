#!/bin/bash

# Script for easy setup the dotfiles

# Set some variable
RST="\033[00m"
BY="\033[01;33m"
BW="\033[01;37m"
BR="\033[01;31m"
es="\001"
ee="\002"

function usage() {
    printf "${es}${BW}${ee}Usage: %s [-i] [-d <dotfiles directory absolute path>] args
\n\t${es}${BY}${ee}The script create a symbolic link for all the dotfiles present in the
\tdefault directory path ${es}${BR}${ee}"~/.dotfiles"${RST}, ${es}${BY}${ee}unless the "-d" args is used for
\tspecifing another path.
\tInteractively choice which file to link using "-i" args.${RST}\n\n" $0
}

while getopts ":d:iph" optname; do
    case "${optname}" in
        "d") DOTFILES_DIR=${OPTARG} ;; 
        "i") INTERACTIVE=true ;; 
        "p") PULL=true ;; 
        "?"|"h"|":") usage
            exit 2;;
    esac
done

DOTFILES_DIR=${DOTFILES_DIR=~/.dotfiles}
DOTFILES="$(find ${DOTFILES_DIR} -mindepth 1 -maxdepth 1 \
    \( -iname "*.*" \
    -a ! \( -iname ".git" -type d \) \
    -a ! \( -iname "bck" -type d \)\
    -a ! -iname "config.sh" \
    -a ! -iname "README.md" \
    -a ! -iname "LICENSE" \
    -a ! -iname ".gitignore" \
    -a ! -iname ".gitmodules" \) \
    2> /dev/null)"
PLUGINS_DIR=${DOTFILES_DIR}/plugins

if [ ! "${DOTFILES_DIR}" ]; then
    echo "Directory ${DOTFILES_DIR} doesn't exist!"
    exit 1
fi

print_status(){
    [[ $? == 0 ]] && echo -e [${es}${BY}${ee}OK${RST}] || \
        echo -e [${es}${BR}${ee}KO${RST}]
}

create_link() {
    echo -n "Create a symbolic link for the file $(basename $f): "
    ln -sr ${DOTFILES_DIR}/${FILENAME} ~/${FILENAME} > /dev/null 2>&1
    if [[ $? == 1 ]]; then
        cd ~
        local DOTFILES_DIR=$(basename ${DOTFILES_DIR})
        ln -s ${DOTFILES_DIR}/${FILENAME} ${FILENAME} > /dev/null 2>&1
    fi
    print_status
}

make_bck() {
    echo -n "${FILENAME} is a file, make a backup: "
    [[ ! -d ${DOTFILES_DIR}/bck ]] && mkdir ${DOTFILES_DIR}/bck -p
    local BCK_FILENAME=${FILENAME}_$(date +%d%m%Y_%H%M)
    mv ~/${FILENAME} ${DOTFILES_DIR}/bck/${BCK_FILENAME} > /dev/null 2>&1
    print_status
}

pull_submodule() {
    if [ -f "${DOTFILES_DIR}/.gitmodules" ];then
        while true; do
            echo -n "Seems like are present some submodules, would you like to pull"
            echo -n "(yes/no): "
            read INPUT
            if [ "${INPUT}" == "yes" -o "${INPUT}" == "YES" ];then
                cd ${DOTFILES_DIR} && \
                git config alias.pullall '!f(){ git pull "$@" && git submodule update --init --recursive; }; f'
                cd ${DOTFILES_DIR} && git pullall
                break
            elif [ "${INPUT}" == "no" -o "${INPUT}" == "NO" ];then
                break
            else
                echo "Answer yes/YES or no/NO"
            fi
        done
    fi
}

check_and_create() {
    if [ -h ~/${FILENAME} ];then 
        echo "The symbolic link exist for the file ${FILENAME}"
    elif [ -f ~/${FILENAME} ];then
        make_bck
        create_link
    else
        create_link
    fi
}

interactive () {
    for f in ${DOTFILES}; do
        FILENAME=$(basename $f)
        while true; do 
            echo -n "Would you like to create symlink for the "${f}" file? "
            echo -n "(yes/no): "
            read INPUT
            if [ "${INPUT}" == "yes" -o "${INPUT}" == "YES" ];then
                check_and_create
                break
            elif [ "${INPUT}" == "no" -o "${INPUT}" == "NO" ];then
                break
                continue
            else
                echo "Answer yes/YES or no/NO"
            fi
        done
    done
}

exec_plugins() {
    [[ `find ${PLUGINS_DIR} -executable -type f` ]]
    if [ "$?" == "0" ]; then
        while true; do
            echo -n "Seems like are present some plugins, would you like to execute: "
            echo -n "(yes/no): "
            read INPUT
            if [ "${INPUT}" == "yes" -o "${INPUT}" == "YES" ];then
                for f in `ls ${PLUGINS_DIR}`; do
                    echo -n "Exec plugin ${f}: "
                    ${PLUGINS_DIR}/${f} > /dev/null 2>&1
                    print_status
                done
                break
            elif [ "${INPUT}" == "no" -o "${INPUT}" == "NO" ];then
                break
            else
                echo "Answer yes/YES or no/NO"
            fi
        done
    fi
}

if [ ${INTERACTIVE} ];then
    interactive
    exec_plugins
    pull_submodule
elif [ ${PULL} ];then
    exec_plugins
    pull_submodule
else
    for f in ${DOTFILES}; do
        FILENAME=$(basename $f)
        check_and_create
    done
    exec_plugins
    pull_submodule
fi

# vim:ts=8:sts=4:sw=4:tw=79:et:ai
