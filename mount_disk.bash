#!/bin/bash

# Define the disk device name and mount point
disk_device="/dev/nvme1n1"
mount_point="/mnt/data"

# Format the disk with the Ext4 file system
sudo mkfs -t ext4 $disk_device

# Create the mount point directory if it doesn't exist
sudo mkdir -p $mount_point

# Mount the disk
sudo mount $disk_device $mount_point

# Add an entry to /etc/fstab for automatic mounting on boot
echo "$disk_device   $mount_point   ext4   defaults,nofail   0   2" | sudo tee -a /etc/fstab

sudo chown ubuntu:ubuntu /mnt/data
