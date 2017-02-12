#!/bin/bash

log () { echo -e "\\033[01;38;5;46m$1\\033[0m"; }
err () { echo -e "\\033[01;38;5;202m$1\\033[0m"; exit 1; }

if [ -z "$1" ]; then err "A target CSS file must be supplied as an argument."; fi

log "Compiling..."
make > /dev/null
if [ $? -ne 0 ]; then err "Invalid styles."; fi
style=`cat $1 | sed -e 's/^.*regexp.*)\s{\s//'`
echo "${style::-1}" | xclip -sel clip
log "Style copied to clipboard."
