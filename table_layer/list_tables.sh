#!/bin/bash

if [ ! "$(ls -A $(pwd) 2>/dev/null)" ]
then
    echo No Tables exist, please create a Table.
else
    ls $(pwd) 2>/dev/null
fi
