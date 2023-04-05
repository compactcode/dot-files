#!/bin/sh

set -eux

# The size of the boot partition.
BOOT_LABEL=boot
MAIN_LABEL=nixos

# Partition using gpt as required by UEFI.
sudo -i parted $INSTALL_DRIVE_NAME -- mklabel gpt
# Boot partition
sudo -i parted $INSTALL_DRIVE_NAME -- mkpart ESP fat32 1MiB 512MiB
# Primary partition
sudo -i parted $INSTALL_DRIVE_NAME -- mkpart primary 512MiB 100%
# Enable the boot partition.
sudo -i parted $INSTALL_DRIVE_NAME -- set 1 boot on

# Wait for disk labels to be ready.
sleep 4

# Setup encryption on the primary partition.
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksFormat /dev/disk/by-partlabel/primary"
# Mount a decrypted version of the encrypted primary partition.
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksOpen /dev/disk/by-partlabel/primary $MAIN_LABEL-decrypted"

# Format the boot partition.
sudo -i mkfs.fat -F 32 -n $BOOT_LABEL /dev/disk/by-partlabel/ESP
# Format the primary partition.
sudo -i mkfs.btrfs -L $MAIN_LABEL /dev/mapper/$MAIN_LABEL-decrypted

# Wait for disk labels to be ready.
sleep 4

# Create btrfs subvolumes
sudo -i mkdir -p /mnt
sudo -i mount /dev/disk/by-label/$MAIN_LABEL /mnt
sudo -i btrfs subvolume create /mnt/root
sudo -i btrfs subvolume create /mnt/home
sudo -i btrfs subvolume create /mnt/nix
sudo -i btrfs subvolume create /mnt/swap
sudo -i umount /mnt

# Mount the main & boot partitions.
sudo -i mount -o compress=zstd,subvol=root /dev/disk/by-label/$MAIN_LABEL /mnt
sudo -i mkdir /mnt/{home,nix,swap}
sudo -i mount -o compress=zstd,subvol=home /dev/disk/by-label/$MAIN_LABEL /mnt/home
sudo -i mount -o compress=zstd,noatime,subvol=nix /dev/disk/by-label/$MAIN_LABEL /mnt/nix

# Mount the boot partition within main for installation.
sudo -i mkdir /mnt/boot
sudo -i mount /dev//disk/by-label/$BOOT_LABEL /mnt/boot

# Mount the swap partition within main for installation.
sudo -i mount -o subvol=swap /dev/disk/by-label/$MAIN_LABEL /mnt/swap
sudo -i btrfs filesystem mkswapfile --size 4g /mnt/swap/swapfile
sudo -i swapon /mnt/swap/swapfile
