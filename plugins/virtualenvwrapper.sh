#!/bin/bash

install_virtualenvwrapper() {
    `which pip` install --user virtualenvwrapper
}

[[ `which virtualenvwrapper.sh` ]] > /dev/null 2>&1
if [ "$?" == "1" ]; then
    install_virtualenvwrapper
fi

