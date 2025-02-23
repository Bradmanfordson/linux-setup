#!/bin/bash

PROJECT="/home/brad/Projects/bradmanfordson.github.io"
JOURNAL="_articles/hackthebox/journal"
DATE=$(date +"%Y-%m-%d")
ENTRY=$PROJECT/$JOURNAL/$DATE.md

function make_entry {
    touch $ENTRY
    echo "---" >> $ENTRY
    echo "layout: Journal" >> $ENTRY
    echo "title: who knows" >> $ENTRY
    echo "date: $DATE" >> $ENTRY
    echo "categories: Journal" >> $ENTRY
    echo $'---\n\n' >> $ENTRY
}

function open_entry {
    cd $PROJECT
    code $ENTRY
}

if [ ! -f $ENTRY ]; then
    make_entry
fi

open_entry

