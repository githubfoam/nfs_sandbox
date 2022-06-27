#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

#install nfs
apt-get update
apt-get install nfs-common -y

#nfs server shared directory
NFS_DIR="/mnt/nfs_share"

# create a mount point,on which mount the nfs share from the NFS server
mkdir -p /mnt/nfs_clientshare

#mounting the NFS share that is shared by the NFS server
#enable the client system to access the shared directory
# nfs server IP
# 192.168.50.6:/mnt/nfs_share  /mnt/nfs_clientshare
mount 192.168.50.6:$NFS_DIR  /mnt/nfs_clientshare

# #Testing the NFS Share
whoami #verify not root user
#run as vagrant user
sudo -u vagrant touch /mnt/nfs_clientshare/file.txt
sudo -u vagrant ls -l /mnt/nfs_clientshare/

df -h