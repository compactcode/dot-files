#!/bin/sh

set -eux

# The size of the boot partition.
BOOT_SIZE=512MiB

# Partition using gpt as required by UEFI.
sudo -i parted $INSTALL_DRIVE_NAME -- mklabel gpt
# Boot partition
sudo -i parted $INSTALL_DRIVE_NAME -- mkpart ESP fat32 1MiB $BOOT_SIZE
# Primary partition
sudo -i parted $INSTALL_DRIVE_NAME -- mkpart primary $BOOT_SIZE 100%
# Enable the boot partition.
sudo -i parted $INSTALL_DRIVE_NAME -- set 1 boot on

# Wait for disk labels to be ready.
sleep 4

# Format the boot partition.
sudo -i mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP
# Format the primary partition.
sudo -i mkfs.btrfs -L nixos /dev/disk/by-partlabel/primary

# Wait for disk labels to be ready.
sleep 4

# Create btrfs subvolumes
sudo -i mkdir -p /mnt
sudo -i mount /dev/disk/by-label/nixos /mnt
sudo -i btrfs subvolume create /mnt/root
sudo -i btrfs subvolume create /mnt/home
sudo -i btrfs subvolume create /mnt/nix
sudo -i btrfs subvolume create /mnt/swap
sudo -i umount /mnt

# Mount the nixos & boot partitions.
sudo -i mount -o compress=zstd,subvol=root /dev/disk/by-label/nixos /mnt
sudo -i mkdir /mnt/{home,nix,swap}
sudo -i mount -o compress=zstd,subvol=home /dev/disk/by-label/nixos /mnt/home
sudo -i mount -o compress=zstd,noatime,subvol=nix /dev/disk/by-label/nixos /mnt/nix

# Mount the boot partition within the nixos.
sudo -i mkdir /mnt/boot
sudo -i mount /dev//disk/by-label/boot /mnt/boot

# Mount the swap partition within the nixos.
sudo -i mount -o subvol=swap /dev/disk/by-label/nixos /mnt/swap
sudo -i btrfs filesystem mkswapfile --size 4g /mnt/swap/swapfile
sudo -i swapon /mnt/swap/swapfile
