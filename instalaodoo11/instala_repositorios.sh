#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "La instalación debe hacerse como root" 1>&2
   exit 1
fi

source config.sh

RUTA=`pwd`

cd $INSTAL_BASE

while IFS='' read -r line || [[ -n "$line" ]]; do

    git pull $line
    if [ $? -ne 0 ]; then
	git clone --depth 1 --branch 11.0 --single-branch $line
    fi
    
done < $RUTA/repositorios.txt

$RUTA
