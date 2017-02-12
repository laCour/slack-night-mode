#!/bin/bash

log () { echo -e "\\033[01;38;5;46m$1\\033[0m"; }
err () { echo -e "\\033[01;38;5;202m$1\\033[0m"; exit 1; }

if [ -z "$1" ]; then err "A target CSS file must be supplied as an argument."; fi

log "Compiling..."
make > /dev/null
if [ $? -ne 0 ]; then err "Invalid styles."; fi
style=`cat $1`

log "Finding and updating style..."
style_url="http://userstyles.org/styles/117475"
profile="*.default"
database_path="$HOME/.mozilla/firefox/$profile/stylish.sqlite"
style_id=`sqlite3 $database_path "SELECT id FROM styles WHERE idUrl = '$style_url';"`
if [ "$style_id" == "" ]; then err "Style not found in Firefox Stylish database."; fi
echo "UPDATE styles SET code='$style',enabled=0 WHERE id=$style_id;" | sqlite3 $database_path

log "Style updated and disabled. Enable the style to reflect changes."
