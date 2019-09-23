#!/bin/bash

# need to use sshpass for linux

echo "sending commands to $1 host"

#sshpass -e ssh-copy-id root@$1

sshpass -e rsh root@$1 'partedUtil  mklabel "/vmfs/devices/disks/mpx.vmhba0:C0:T2:L0" gpt'
sshpass -e rsh root@$1 'partedUtil setptbl "/vmfs/devices/disks/mpx.vmhba0:C0:T2:L0" gpt "1 2048 1677721566 AA31E02A400F11DB9590000C2911D1B8 0"'
sshpass -e rsh root@$1 'vmkfstools -C vmfs5 -b 1m -S datastore /vmfs/devices/disks/mpx.vmhba0:C0:T2:L0:1'
