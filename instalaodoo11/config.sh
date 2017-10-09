#!/bin/bash

# Directorio base de instalación y versión de Odoo
INSTAL_BASE=/opt/odoo

#INSTAL_VERSION=odoo
#INSTAL_DIR=$INSTAL_BASE/$INSTAL_VERSION

# Addons externos
ADDONS_DIR=$INSTAL_BASE/other-addons

# Addons para cluientes (directorio base)
ADDONS_CLIENTES=$INSTAL_BASE/clientes


# Usuario y grupo
ODOO_USER="odoo"
ODOO_GROUP="odoo"

# Config
#
# Para una instalación base, única en el servidor:
#  ODOO_CONFIGURATION_FILE=$ODOO_CONFIGURATION/odoo.conf
#
# Para cada instancia tendrá su propio fichero de configuración:
#  ODOO_CONFIGURATION_FILE=$ODOO_CONFIGURATION/odoo-$COD-CLIENTE.conf
 
ODOO_CONFIGURATION=/etc/odoo
ODOO_CONFIGURATION_FILE=$ODOO_CONFIGURATION/odoo.conf
CONF_PLANTILLA=odoo.conf

# Datos
ODOO_DATA_DIR=/opt/odoo

# Log
ODOO_LOG_DIR=/var/log/odoo

# Servicio para lanzar la instancia
SERVICIO="odoo"


# backup temporal
BACKUP_TMP_DIR=/opt/filebck
#$BACKUP_TMP_FILE=backup_tmp_odoo.tar.gz
