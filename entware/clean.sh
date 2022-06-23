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

: "============================= CLEAN $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/clean.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"

# ensure services are stopped
/opt/etc/init.d/rc.unslung stop

[ -L /etc/profile ] && rm -f /etc/profile

# restore home dir
if mountpoint /home; then
	if ! umount /home; then
		: "mount /home failed. try to kill"
		fuser -cv /home
		fuser -ck /home
		sleep 2
		if ! umount /home; then
			umount -l /home
		fi
	fi
fi

# umount, the original /opt mount becomes visible again
if ! umount /opt; then
	: "umount /opt failed. try to kill"
	fuser -cv /opt
	fuser -ck /opt
	sleep 2
	if ! umount /opt; then
		umount -l /opt
	fi
fi

# remove web
rm -rf /var/www/apps/entware
rm -f /var/www/cgi-bin/entware.py

} >>${LOG} 2>&1
