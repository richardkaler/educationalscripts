#!/bin/bash

read -r -p "Enter the hash value to search for: " hashval

#hashval="randomhash" #NOTE: in this case, the end user is not feeding the hash through the prompt. It is already in the script. 
#The problem with this though is that each time a user wants to run the script he or she has to edit it ... and that is very inefficient if the script has to be run for multiple files where frequent edits
#are required

if [[ -n "$hashval" ]]; then 
find "$PWD" -maxdepth 1 -type f | while IFS= read -r item
do
    pattern=$(sha256sum "$item" | awk '{ print $1 }') 
    if [[ "$pattern"  == "$hashval" ]]; then 
        echo "ALERT! found suspicious item below"
        ls -l "$item"
        exit 0 
    else 
        echo "safe: $item: $pattern" 
    fi
done
else 
    echo "enter a value to process script" 
    exit 1 
fi

#Grep method below 

#for item in "$PWD"/* 
#do
#    echo "processing $item" 
#val="$(find "$PWD" -maxdepth 1 -type f -exec sha256sum {} + | grep "$hashval")" 
#if [[ -n "$val" ]]; then 
#    echo "got a match:$val"
#    echo exiting script
#    exit 0 
#else 
#    echo "$val doesn't match" 
#fi
#done

#Without loop 
#find . -type f -exec sha256sum {} + | grep "$hashval"

