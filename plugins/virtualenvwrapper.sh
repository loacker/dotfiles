#!/bin/bash

PATH=$PATH:~/.local/bin

install_pip() {
    curl https://bootstrap.pypa.io/get-pip.py -o - | \
        python - --user > /dev/null 2>&1
}

[[ `which pip` ]] > /dev/null 2>&1
if [ "$?" == "1" ]; then
    install_pip
fi

install_virtualenvwrapper() {
    `which pip` install --user virtualenvwrapper
}

[[ `which virtualenvwrapper.sh` ]] > /dev/null 2>&1
if [ "$?" == "1" ]; then
    install_virtualenvwrapper
fi

