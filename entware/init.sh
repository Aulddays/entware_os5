#!/bin/bash

LOG=/tmp/entware.log

set -x

{

: "============================= INIT $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/init.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"


APPDIR=$1

: "Entware init.sh linking files from path: $APPDIR"

# create link to binary...
OPKG=/opt/bin/opkg
OPTROOT=${APPDIR}.root
if [ ! -f $OPKG ]; then
	[ ! -d $OPTROOT ] && echo "Entware root dir not found!"  && exit 1
	mount --bind $OPTROOT /opt
	: "DEBUG: Mounted Entware root to /opt"
fi

# set profile
PROFILE=/etc/profile
[ ! -f $PROFILE ] && ln -s $APPDIR/profile $PROFILE

# set home dir
HOME=/home
NEWHOME=$(dirname ${APPDIR})/persist_home
if [ ! -L ${HOME} ]; then
	: "Setup persistent home directory"
	mv ${HOME} ${HOME}.bak
	mkdir -p ${NEWHOME}/root
	ln -sf ${NEWHOME} ${HOME}
	chown root:root ${HOME}/root
	chown root:root ${NEWHOME}
fi

WEBPATH=/var/www
CGI_BIN="${WEBPATH}/cgi-bin"
APP_WEBPATH=${WEBPATH}/apps/entware/
mkdir -p $APP_WEBPATH
ln -sf $APPDIR/web/* $APP_WEBPATH
ln -sf $APPDIR/cgi-bin/entware.py $CGI_BIN/
: "Created Entware web dir symlink"

} >>${LOG} 2>&1
