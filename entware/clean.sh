#!/bin/bash

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
if [ -L /home ]; then
	rm -f /home
	mv /home.bak /home
	chown root:root /home
fi

# umount, the original /opt mount becomes visible again
umount /opt

if [ $? -ne 0 ] ; then
   echo "Entware clean umount failed"
   fuser -cv /opt
   : "Kill them all"
   fuser -ck /opt
   sleep 2
   umount /opt
fi

# remove web
rm -rf /var/www/apps/entware
rm -f /var/www/cgi-bin/entware.py

} >>${LOG} 2>&1
