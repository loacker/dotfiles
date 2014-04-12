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
\tdefault directory path ${es}${BR}${ee}"~/dotfiles"${RST}, ${es}${BY}${ee}unless the "-d" args is used for
\tspecifing another path.
\tInteractively choice which file to link using "-i" args.${RST}\n\n" $0
}

DOTFILES_DIR=${DOTFILES_DIR=~/dotfiles}
DOTFILES="$(find ${DOTFILES_DIR} -maxdepth 1 \
    \( -iname "*.*" -a ! \( -iname ".git*" -type d \) -a ! -iname "*config.sh*" \) \
    2> /dev/null)"

while getopts ":d:ih" optname; do
    case "$optname" in
        "d") DOTFILES_DIR=$OPTARG ;; 
        "i") INTERACTIVE=true ;; 
        "?"|"h"|":") usage
            exit 2;;
    esac
done

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
    ln -s $f ~/$(basename $f) > /dev/null 2>&1
    print_status
}

make_bck() {
    echo -n "$(basename $f) is a file, make a backup: "
    [[ ! -d ${DOTFILES_DIR}/bck ]] && mkdir ${DOTFILES_DIR}/bck -p
    mv ~/${filename} ${DOTFILES_DIR}/bck/${filename}_$(date +%d%m%Y_%H%M) > /dev/null 2>&1
    print_status
}

if [ ${INTERACTIVE} ];then
    for f in $DOTFILES; do
        while true; do 
            echo -n "Would you like to create symlink for the "$f" file? "
            echo -n "(yes/no): "
            read INPUT
            if [ "$INPUT" == "yes" -o "$INPUT" == "YES" ];then
                create_link
                break
            elif [ "$INPUT" == "no" -o "$INPUT" == "NO" ];then
                break
                continue
            else
                echo "Answer yes/YES or no/NO"
            fi
        done
    done
else
    for f in $DOTFILES; do
        filename=$(basename $f)
        if [ -h ~/${filename} ];then 
            echo "The symbolic link exist for the file ${filename}"
        elif [ -f ~/${filename} ];then
            make_bck
            create_link
        else
            create_link
        fi
    done

fi

# vim:ts=8:sts=4:sw=4:tw=79:et:ai
