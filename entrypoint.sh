#!/bin/bash

set -e

mounts="${@}"

for mnt in "${mounts[@]}"; do
    src=$(echo $mnt | awk -F':' '{ print $1 }')
    ! [ -d /exports/${src:1} ] && mkdir -p /exports/${src:1}
    mount --bind $src /exports/${src:1}
    echo "$src *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
done

. /etc/default/nfs-kernel-server
. /etc/default/nfs-common

rpcbind
service nfs-kernel-server start

exec inotifywait -rm /exports
