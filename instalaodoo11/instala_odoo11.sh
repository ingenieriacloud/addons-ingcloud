#!/bin/bash
##################################################################
## Proceso de instalación de Odoo
##
##
##################################################################
## Uso del script:
##  instala_odoo11.sh <usuario>
##
## usuario: Nombre o código de cliente.
##  Se utilizará para crear la configuración y la base de datos.
#################################################################

if [ "$(id -u)" != "0" ]; then
   echo "La instalación debe hacerse como root" 1>&2
   exit 1
fi

source config.sh

apt-get update

apt-get upgrade -y

apt-get install wget git bzrtools python3-pip python3-dev -y

apt-get install adduser postgresql postgresql-client postgresql-contrib poppler-utils xfonts-base xfonts-75dpi node-less node-clean-css libevent-dev libxslt1-dev libsasl2-dev libxml2-dev libpq-dev libpng12-dev libjpeg-dev -y

pip3 install --upgrade pip

pip3 install Babel decorator docutils ebaysdk feedparser gevent greenlet html2text Jinja2 lxml Mako MarkupSafe mock num2words ofxparse passlib Pillow psutil psycogreen psycopg2 pydot pyparsing PyPDF2 pyserial python-dateutil python-openid pytz pyusb PyYAML qrcode reportlab requests six suds-jurko vatnumber vobject Werkzeug XlsxWriter xlwt xlrd unicodecsv pysftp gdata phonenumbers pyopenssl


if [ ! -d "$INSTAL_BASE" ]; then
    mkdir $INSTAL_BASE
fi

#Creo el grupo si no existe
groupadd -f $ODOO_GROUP
# Crea el usuario de sistema
if ! getent passwd | grep -q "^odoo:"; then
    #adduser --home $ODOO_DATA_DIR --quiet --group $ODOO_USER
    useradd -g $ODOO_GROUP -d $ODOO_DATA_DIR -m $ODOO_USER
fi

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

# Log
mkdir -p $ODOO_LOG_DIR
chown $ODOO_USER:$ODOO_GROUP $ODOO_LOG_DIR
chmod 0750 $ODOO_LOG_DIR

# Directorio de datos
if [ ! -d "$ODOO_DATA_DIR" ]; then
    mkdir $ODOO_DATA_DIR
fi
chown $ODOO_USER:$ODOO_GROUP $ODOO_DATA_DIR

# Run Script
cp `pwd`/init /etc/init.d/$SERVICIO
chmod 0755 /etc/init.d/$SERVICIO
chown root: /etc/init.d/$SERVICIO
# Crear servicio.
update-rc.d $SERVICIO defaults


# Instala dependencias Node.js: less css.
npm install -g less less-plugin-clean-css

# Sin este enlace da error al crear la bbdd relacionado con idioma y utf:
ln -s /usr/bin/nodejs /usr/bin/node

# Instalar o actualizar módulos desde repositorios GitHub.
./instala_repositorios.sh

# Crea el directorio para clientes y con privilegios para Odoo
if [ ! -d "$ADDONS_CLIENTES" ]; then
    mkdir $ADDONS_CLIENTES
fi
# Crea el directorio Other-addons
if [ ! -d "$ADDONS_DIR" ]; then
    mkdir $ADDONS_DIR
fi



# Privilegios al usuario ODOO En todo el arbol de /opt/openerp
chown -R $ODOO_USER:$ODOO_GROUP $INSTAL_BASE


# Instalo módulos externos OCA
# --- por ahora no hace falta. se hace desde instala_repositorios.sh
##sh `pwd`/repositorios_OCA.sh
##chown -R $ODOO_USER:$ODOO_GROUP $ADDONS_DIR

# addons
# -- por ahora no hace falta ---

##ADDONS_STR=""
##ADDONS=""
##for dir in $ADDONS_DIR/* ; do  ADDONS=$ADDONS$dir','; done;
##ADDONS_STR=$ADDONS$INSTAL_DIR"/addons"
##echo "addons_path= "$ADDONS_STR >> $ODOO_CONFIGURATION_FILE

# Descarga e instala Wkhtmltopdf
# wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
# dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
# rm wkhtmltox-0.12.1_linux-trusty-amd64.deb*
# cp /usr/local/bin/wkhtmlto* /usr/bin/
# cp -f wkhtmlto* /usr/local/bin/
# cp -f wkhtmlto* /usr/bin/

# Copia fichero de permisos para el usuario Odoo por si root ha descargado o hecho cambios y queremos homogeneizar:
cp -a permisos.sh /opt/odoo

# Genera enlaces básicos de OCA y terceros para v10 en opt/odoo/other-addons:
# ./enlaces

# Lanza Odoo
/etc/init.d/odoo restart

