#!/bin/sh

set -ex

export INSTALL_DRIVE_NAME=?
export INSTALL_DRIVE_PASSWORD=?

./install-channels.sh
./prepare-uefi-filesystem.sh

# Select the machine to install.
ln -s /tmp/dot-files/nixos/machines/medusa.nix /mnt/etc/nixos/configuration.nix

# 🚀
sudo -i nixos-install --no-root-passwd
