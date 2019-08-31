#!/bin/sh

set -eux

# The size of the boot partition.
BOOT_SIZE=512MiB

# Partition using gpt as required by UEFI.
parted $INSTALL_DRIVE_NAME -- mklabel gpt
# Boot partition
parted $INSTALL_DRIVE_NAME -- mkpart ESP fat32 1MiB $BOOT_SIZE
# Primary partition
parted $INSTALL_DRIVE_NAME -- mkpart primary $BOOT_SIZE 100%
# Enable the boot partition.
parted $INSTALL_DRIVE_NAME -- set 1 boot on

# Setup encryption on the primary partition.
echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksFormat /dev/disk/by-partlabel/primary
# Mount a decrypted version of the encrypted primary partition.
echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksOpen /dev/disk/by-partlabel/primary nixos-decrypted

# Format the boot partition.
mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP
# Format the decrypted version of the primary partition.
mkfs.ext4 -L nixos /dev/mapper/nixos-decrypted

# Wait for disk labels to be ready.
sleep 4

# Mount the primary & boot partitions.
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot  /mnt/boot

# Prepare a directory to place dotfiles.
mkdir -p /mnt/etc/dotfiles/nixos

# Prepare the directory to place the nix configuration.
mkdir -p /mnt/etc/nixos
