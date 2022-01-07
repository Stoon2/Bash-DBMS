#!/bin/bash
if [ ! "$(ls -A $1 2>/dev/null)" ] #Validation to check existing tables first
then
    echo "No Tables exist, please create a Table."
else
    ls $1 2>/dev/null #Listing
fi
