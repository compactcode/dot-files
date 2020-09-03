#!/bin/sh

set -ex

# Select the machine to install.
ln -s /mnt/etc/dotfiles/nixos/machines/nixvm.nix /mnt/etc/nixos/configuration.nix

# 🚀
sudo -i nixos-install --no-root-passwd
