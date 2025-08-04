#!/usr/bin/env bash

cd $1
if git status --no-verbose > /dev/null 2> /dev/null; then
    unstaged=$(
        count=`git diff --name-only | wc -l`
        if [ "$count" -ne 0 ]; then
            echo " $count | "
        fi
    )
    staged=$(
        count=`git diff --name-only --cached | wc -l`
        if [ "$count" -ne 0 ]; then
            echo "󰐗 $count | "
        fi
    )
    branch="󰘬 `git rev-parse --abbrev-ref HEAD`"
    out="$unstaged$staged$branch"
else
    out=""
fi
echo $out

