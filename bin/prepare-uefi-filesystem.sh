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
sudo sh -c "echo $INSTALL_DRIVE_PASSWORD | cryptsetup luksOpen /dev/disk/by-partlabel/primary unlocked"

# Setup logical volumes on our decrypted drive.
sudo -i pvcreate /dev/mapper/unlocked
# Create a logical volume group so we can add a swap partition.
sudo -i vgcreate unlocked-lvm /dev/mapper/unlocked
# Create a logical volume for swap.
sudo -i lvcreate -L 8G -n swap unlocked-lvm
# Create a logical volume for the main os.
sudo -i lvcreate -l '100%FREE' -n nixos unlocked-lvm

# Format the boot partition.
sudo -i mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP
# Format the main os partition.
sudo -i mkfs.ext4 -L nixos /dev/unlocked-lvm/nixos
# Format the swap partition.
sudo -i mkswap -L swap /dev/unlocked-lvm/swap

# Wait for disk labels to be ready.
sleep 4

# Mount the primary & boot partitions.
sudo -i mount -o noatime /dev/unlocked-lvm/nixos /mnt
sudo -i mkdir /mnt/boot
sudo -i mount -o noatime /dev/disk/by-label/boot  /mnt/boot
sudo -i swapon /dev/unlocked-lvm/swap

# Prepare a directory to place dotfiles.
sudo -i mkdir -p /mnt/etc/dotfiles/nixos
sudo -i chown -R nixos /mnt/etc/dotfiles/nixos

# Prepare the directory to place the nix configuration.
sudo -i mkdir -p /mnt/etc/nixos
sudo -i chown -R nixos /mnt/etc/nixos
