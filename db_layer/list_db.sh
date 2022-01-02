#!/bin/bash
<<<<<<< HEAD
PS3="Action:"
ls db_collection
=======
if [ ! -d "$(pwd)/db_collection" ]
then
    echo "db_collection directory does not exist, please create a DB through 'Create a DB' in the main menu."
elif [ ! "$(ls -A $(pwd)/db_collection/ 2> /dev/null)" ]
then
    echo No databases exist, please create a database.
else
    ls db_collection 2> /dev/null
fi
>>>>>>> 5ee5ee34b3898c09e2ad786a4d04cb9d02542eaa
