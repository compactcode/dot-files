#!/bin/sh

set -ex

# The size of the boot partition.
BOOT_SIZE=512MiB

# The drive we will be installing on.
DRIVE_NAME=/dev/sda

# Partition using gpt as required by UEFI.
parted $DRIVE_NAME -- mklabel gpt
# Boot partition (sda1)
parted $DRIVE_NAME -- mkpart ESP fat32 1MiB $BOOT_SIZE
# Primary partition (sda2)
parted $DRIVE_NAME -- mkpart primary $BOOT_SIZE 100%
# Enable the boot partition.
parted $DRIVE_NAME -- set 1 boot on

# Format the boot partition.
mkfs.fat -F 32 -n boot ${DRIVE_NAME}1
# Format the primary partition.
mkfs.ext4 -L nixos ${DRIVE_NAME}2

# Wait for disk labels to be ready.
sleep 4

# Mount the primary & boot partitions.
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot  /mnt/boot

# Prepare a directory to upload our nix configuration.
mkdir -p /mnt/etc/nixos
