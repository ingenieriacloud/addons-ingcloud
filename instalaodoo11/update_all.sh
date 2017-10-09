#!/bin/bash
################################################
## Update_all
##
## Actualiza todos los módulos
################################################

if [ "$(id -u)" != "0" ]; then
   echo "La instalación debe hacerse como root" 1>&2
   exit 1
fi

source config.sh
RUTA=`pwd`

while IFS='' read -r line || [[ -n "$line" ]]; do
    /etc/init.d/odoo-$line stop
    su odoo -c "/opt/odoo/odoo/odoo-bin -c /etc/odoo/odoo-$line.conf -u all -d $line"
    /etc/init.d/odoo-$line start

done < $RUTA/bdinstanciasparaupdateall.txt


