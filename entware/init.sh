#!/bin/bash

# entware installer for My Cloud OS5
# Copyright (C) 2022  Aulddays  https://github.com/Aulddays/entware_os5
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

LOG=/tmp/entware.log

set -x

{

: "============================= INIT $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/init.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"


APPDIR=$1

# dir that will be mounted on /opt, in which all entware stuff will be installed
OPTROOT=${APPDIR}.root
# dir that will be mounted on /home, so that changes in /home will persist
HOMEPERSIST=$(dirname ${APPDIR})/persist_home

: "Entware init.sh linking files from path: $APPDIR"

# mount $OPTROOT if has not
OPKG=/opt/bin/opkg
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
if [[ -d ${HOME} && ! -L ${HOME} ]]; then
	if ! mountpoint ${HOME}; then
		: "Setup persistent home directory"
		mkdir -p ${HOMEPERSIST}/root
		chown root:root ${HOMEPERSIST}
		mount --bind ${HOMEPERSIST} ${HOME}
	fi
fi

WEBPATH=/var/www
CGI_BIN="${WEBPATH}/cgi-bin"
APP_WEBPATH=${WEBPATH}/apps/entware/
mkdir -p $APP_WEBPATH
ln -sf $APPDIR/web/* $APP_WEBPATH
ln -sf $APPDIR/cgi-bin/entware.py $CGI_BIN/
: "Created Entware web dir symlink"

} >>${LOG} 2>&1
