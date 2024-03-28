#!/bin/sh


if [ -z "$1" ]; then
    selected=$(find ~/HDD/projects ~/.config ~/ -mindepth 0 -maxdepth 1 -type d | fzf)
else
    selected=$1
fi

if [ -z "$selected" ]; then 
    echo "No session selected"
    exit 0
fi

if [ -z "$2" ]; then
    name=$(basename $selected | tr . _)
else
    name=$2
fi

if [ -z "$TMUX" ]; then
    tmux new-session -s $name -c $selected
    tmux attach-session -t $name
else
    if ! tmux has-session -t $name; then
        tmux new-session -ds $name -c $selected
    fi

    tmux switch-client -t $name
fi



