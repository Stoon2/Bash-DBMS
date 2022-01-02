#!/bin/bash

mkdir -p "$(pwd)/db_collection/$1/"
chmod a+x "$(pwd)/db_collection/$1/" # insure execute permission is given on created dirs
echo $1 is created successfully