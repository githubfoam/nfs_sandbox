#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

#install nfs
dnf update -y
dnf install nfs-utils nfs4-acl-tools -y

# create a mount point,on which mount the nfs share from the NFS server
mkdir -p /mnt/nfs_clientshare

#mounting the NFS share that is shared by the NFS server
#enable the client system to access the shared directory
mount -t nfs 192.168.50.6:/mnt/nfs_share  /mnt/nfs_clientshare

mount | grep nfs
# mount information for the NFS server
showmount -e  192.168.50.6

#Testing the NFS Share
touch /mnt/nfs_clientshare/file1.txt
ls -l /mnt/nfs_clientshare/

whoami
echo "192.168.50.6:/mnt/nfs_share  /mnt/nfs_clientshare  nfs     defaults 0 0" | tee -a /etc/fstab
