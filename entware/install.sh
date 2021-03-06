#!/bin/sh

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

: "============================= INSTALL $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/_install/entware/install.sh /mnt/HD/HD_a2/Nas_Prog/_install/entware /mnt/HD/HD_a2/Nas_Prog
: "CMD: $0 $@"

path_src=$1	# /mnt/HD/HD_a2/Nas_Prog/_install/entware
NAS_PROG=$2	# /mnt/HD/HD_a2/Nas_Prog

# dir that will be mounted on /opt, in which all entware stuff will be installed
OPTROOT="${NAS_PROG}/entware.root"

APPDIR="${NAS_PROG}/entware"

# copy the package to App
cp -rf ${path_src} ${NAS_PROG}

# create the entware root in a location that is not shared by samba
mkdir -p ${OPTROOT}
: "DEBUG: mount $OPTROOT to /opt"
mount --bind ${OPTROOT} /opt >&2

ARCH="$(uname -m)"
if [ ${ARCH} = "x86_64" ]; then
    ENT_ARCH="x64"
elif [ ${ARCH} = "armv5tel" ]; then
    ENT_ARCH="armv5sf"
else
    ENT_ARCH="armv7sf"
fi

: "DEBUG: download and install entware-ng for $ARCH"
wget -O - "http://bin.entware.net/${ENT_ARCH}-k3.2/installer/generic.sh" | /bin/sh

/opt/bin/opkg update
/opt/bin/opkg upgrade

: "DEBUG: keep old WD reboot"
sed -i "s|ENTWARE_DIR|${APPDIR}|" ${APPDIR}/sbin/reboot
ln -sf ${APPDIR}/sbin/reboot /opt/sbin/reboot

: "Copy those are already in /opt"
echo \
'/usr/local/modules/opt/wd
/usr/local/modules/perl5
/usr/local/firefly' \
| while read target; do
	[ -e ${target} ] && ln -sf ${target} /opt/$(basename ${target})
done

: "DEBUG: Unmount again"
umount /opt

: "DEBUG: entware install.sh ready"

} >>${LOG} 2>&1
