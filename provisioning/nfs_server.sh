#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

#install nfs
apt-get update
apt-get install nfs-kernel-server -y

# create NFS mount directory
NFS_DIR="/mnt/nfs_share"
mkdir -p $NFS_DIR

#remove any restrictions
chown -R nobody:nogroup $NFS_DIR

chmod 777 $NFS_DIR

#Permissions for accessing the NFS server
cat /etc/exports

#Grant NFS Share Access to Client Systems
# /mnt/nfs_share  client_IP_1 (re,sync,no_subtree_check)
echo "$NFS_DIR  192.168.50.7(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
echo "$NFS_DIR  192.168.50.8(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
# echo "$NFS_DIR  192.168.50.0/24(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports

#verify
cat /etc/exports

systemctl restart nfs-kernel-server
systemctl status nfs-kernel-server

df -h
showmount -e
