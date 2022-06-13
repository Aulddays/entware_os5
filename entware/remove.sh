#!/bin/sh

LOG=/tmp/entware.log

set -x

{

: "============================= REMOVE $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/remove.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"

APKG_PATH=$1

# remove /opt from shell path
[ -L /etc/profile ] && rm -f /etc/profile

# backup entware apps
ENTWARE_ROOT=${APKG_PATH}.root
BACKUP=${ENTWARE_ROOT}.bak
[[ -d ${ENTWARE_ROOT} ]] && mv -f ${ENTWARE_ROOT} ${BACKUP}

rm -rf ${APKG_PATH}

} >>${LOG} 2>&1
