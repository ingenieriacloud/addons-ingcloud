#!/bin/bash
#############################################
# Actualiza la instalación completa de Odoo8
# Y de los módulos instalados.
#
# Inicialmente crea una copia de seguridad,
# Si se produce un error en la copia, detiene
# la actualización.
#
############################################

if [ "$(id -u)" != "0" ]; then
   echo "La instalación debe hacerse como root" 1>&2
   exit 1
fi

source config.sh

RUTA=`pwd`


# Back up de todo el arbol.
# Elimininar primero el directorio.


if [ ! -d "$BACKUP_TMP_DIR" ]; then
    mkdir $BACKUP_TMP_DIR
fi


echo "ATENCIÓN: Para realizar la actualización hay que eliminar las copias backup anteriores."
read -p "¿Estás seguro? [s|n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Ss]$ ]]
then
    echo "No se hace copia Backup. Se continua con la actualización..."
else
    rm -fr $BACKUP_TMP_DIR
    mkdir $BACKUP_TMP_DIR
    cp -arf $INSTAL_BASE $BACKUP_TMP_DIR
    if [ $? -ne 0 ]; then
	echo "-=*[actualiza: ERROR]*=-: No ha sido posible crear la copia temporal de seguridad " $BACKUP_TMP_DIR/$BACKUP_TMP_FILE $INSTAL_BASE
	echo "----- Se cancela la actualización -----"
	exit
    fi
echo "BACKUP ¡Creado con éxito!. Se procede con la actualización"
fi

cd $INSTAL_BASE
for dir in ./* ; do
    if [ -d $dir ]; then
	cd $dir;
	git pull origin 10.0
	cd ..
    fi
done

