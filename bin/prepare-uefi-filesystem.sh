#!/bin/sh

set -ex

# The size of the boot partition.
BOOT_SIZE=512MiB

# The drive we will be installing on.
DRIVE_NAME=/dev/sda

# Partition using gpt as required by UEFI.
parted $DRIVE_NAME -- mklabel gpt
# Boot partition
parted $DRIVE_NAME -- mkpart ESP fat32 1MiB $BOOT_SIZE
# Primary partition
parted $DRIVE_NAME -- mkpart primary $BOOT_SIZE 100%
# Enable the boot partition.
parted $DRIVE_NAME -- set 1 boot on

# Encrypt the primary partition.
echo 'secret' | cryptsetup luksFormat /dev/disk/by-partlabel/primary
# Decrypt the primary partition and mount it.
echo 'secret' | cryptsetup luksOpen /dev/disk/by-partlabel/primary nixos-decrypted

# Format the boot partition.
mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP
# Format the decrypted primary partition.
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
