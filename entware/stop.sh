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

: "============================= STOP $(date) ========================="
# /mnt/HD/HD_a2/Nas_Prog/entware/stop.sh /mnt/HD/HD_a2/Nas_Prog/entware
: "CMD: $0 $@"

# stop all entware init.d services
/opt/etc/init.d/rc.unslung stop

} >>${LOG} 2>&1
