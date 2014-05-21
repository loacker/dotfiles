#!/bin/bash

BIN_PATH=~/bin

runonce_script() {

    [[ ! -d ${BIN_PATH} ]] && mkdir ${BIN_PATH}

    cat > ${BIN_PATH}/runonce << EOF
#!/bin/bash

# Simple script for run a command in background
# Run the command unless it's already running
# ./runonce "<command>" es. ./runonce "screen -S tmp"

pid=\$(pgrep -U \`whoami\` -f "\$@" -x )

check_or_exec() {
    [[ -z \${pid} ]] && \$@ || exit 0
}

check_stat(){
    stat=\$(ps --no-headers -o stat \${pid})
    echo \${stat} | grep -q +
    [[ \$? == 0 ]] && status="fg"
}

check_screen(){
    echo "\$@" | grep -q "screen"
    [[ \$? == 0 ]] && status="bg"
}

check_or_exec
check_stat
check_screen

case \${status} in
    fg) \$@ & ;;
    bg) \$@ ;;
esac

EOF

    chmod +x ${BIN_PATH}/runonce

}

[[ -f "${BIN_PATH}/runonce" ]] || runonce_script

