#!/bin/bash

# remember to change the filename containing the list of folders to keep
# in this example, the filename is cdc-spix-prd01

ROOT_UID=0     # Only users with $UID 0 have root privileges.

SearchDir() {

    while read -r line;
    do        
        #echo "Search .. $1"
        backSlash="/"
        folder2Keep="$line$backSlash"
        if [ "$folder2Keep" = "$1" ]; then
            #echo "found $line EQUAL $1"
            return 100
        fi
    done < cdc-spix-prd01.txt
    return 999
}

echo "start app"

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi 


for d in */; do
    SearchDir "$d"
    if [ "$?" -ne 100 ]; then
        echo "remove $d"
        rm -rf $d
    fi
done