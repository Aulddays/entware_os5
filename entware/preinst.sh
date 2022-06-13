#!/bin/bash

LOG=/tmp/entware.log

set -x

{

: "============================= PREINST $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/preinst.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"

APKG_PATH=$1

# invalidate old entware installation leftovers
# restore them if necessary
ENTWARE_ROOT=${APKG_PATH}.root
BACKUP=${ENTWARE_ROOT}.bak
[[ -d ${ENTWARE_ROOT} ]] && mv -f ${ENTWARE_ROOT} ${BACKUP}

} >>${LOG} 2>&1
