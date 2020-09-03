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

# Setup encryption on the primary partition.
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksFormat /dev/disk/by-partlabel/primary"
# Mount a decrypted version of the encrypted primary partition.
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksOpen /dev/disk/by-partlabel/primary nixos-decrypted"

# Format the boot partition.
sudo -i mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP
# Format the decrypted version of the primary partition.
sudo -i mkfs.ext4 -L nixos /dev/mapper/nixos-decrypted

# Wait for disk labels to be ready.
sleep 4

# Mount the primary & boot partitions.
sudo -i mount -o noatime /dev/disk/by-label/nixos /mnt
sudo -i mkdir /mnt/boot
sudo -i mount -o noatime /dev/disk/by-label/boot  /mnt/boot

# Prepare a directory to place dotfiles.
sudo -i mkdir -p /mnt/etc/dotfiles/nixos
sudo -i chown -R nixos /mnt/etc/dotfiles/nixos

# Prepare the directory to place the nix configuration.
sudo -i mkdir -p /mnt/etc/nixos
sudo -i chown -R nixos /mnt/etc/nixos
