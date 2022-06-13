#!/bin/sh

LOG=/tmp/entware.log

set -x

{

: "============================= START $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/start.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"

# start all entware init.d services
/opt/etc/init.d/rc.unslung start

} >>${LOG} 2>&1
