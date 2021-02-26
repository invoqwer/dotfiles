#!/bin/bash
# Lint all bash scripts

MAIN=$(ls ./*.sh)
SCRIPTS=$(ls ./scripts)

lint () {
    shellcheck "$1"
    if [[ "$?" -eq 1 ]]; then
        # read -r -p "Press any key to continue."
        echo "Fix errors above"
        exit 1
    fi
}

if [[ "$#" -eq 1 ]] && [[ -f "$1" ]] ; then
    lint "$1"
else
    echo "LINTING SCRIPTS"

    for script in $MAIN
    do
        lint "./$script"
    done

    for script in $SCRIPTS
    do
        lint "./scripts/$script"
    done

    echo "LINT OK"
fi

