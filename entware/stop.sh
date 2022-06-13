#!/bin/sh

LOG=/tmp/entware.log

set -x

{

: "============================= STOP $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/stop.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"

# stop all entware init.d services
/opt/etc/init.d/rc.unslung stop

} >>${LOG} 2>&1
