#!/bin/bash
##################################################################
## Proceso de instalación de Odoo 8.
##
## Crea una instancia para un usuario.
##################################################################
## Uso del script:
##  crea_instancia.sh <usuario> <puerto>
##
## usuario: Nombre o código de cliente. (Ejemplo: a105, a110)
## puerto: Puerto en el que correrá la instancia. (Ejemplo: 8070,8071,..)
##
##  Se utilizará para crear la configuración y la base de datos.
#################################################################


if [ "$(id -u)" != "0" ]; then
   echo "La instalación debe hacerse como root" 1>&2
   exit 1
fi

source config.sh


ODOO_CONFIGURATION_FILE=$ODOO_CONFIGURATION/odoo-$1.conf
USER_ADMIN="odoo"

ODOO_USER=$1
#ODOO_GROUP="odoo"
ODOO_PUERTO=$2
ODOO_DATA_DIR=/var/lib/odoo/$1
ODOO_LOG_DIR=/var/log/odoo/$1


#----------------------------------
# Servicio para lanzar la instancia
#----------------------------------
SERVICIO="odoo"


# Crea el usuario de sistema
##if ! getent passwd | grep -q "^$ODOO_USER:"; then
##    adduser --home $ODOO_DATA_DIR --quiet --group $ODOO_USER
##fi

# Crea el usuario administrador de base de datos.
su - postgres -c "createuser -d -R -S $ODOO_USER"

# Configuración.
if [ ! -d "$ODOO_CONFIGURATION" ]; then
    mkdir $ODOO_CONFIGURATION
fi
if [  -f "$ODOO_CONFIGURATION_FILE" ]; then
    mv $ODOO_CONFIGURATION_FILE $ODOO_CONFIGURATION_FILE"_backup"
fi

cp `pwd`/$CONF_PLANTILLA $ODOO_CONFIGURATION_FILE
chown $ODOO_USER:$ODOO_GROUP $ODOO_CONFIGURATION_FILE
chmod 0640 $ODOO_CONFIGURATION_FILE

echo "xmlrpc_port = "$ODOO_PUERTO >> $ODOO_CONFIGURATION_FILE



## Editar /etc/postgresql/X.Y/main/pg_hba.conf
## Añadir:
## local   all         all                               trust

## CREAR USUARIO Postgres
## # su postgres -c "createuser -P <user>; createdb -O <user> <database>"

