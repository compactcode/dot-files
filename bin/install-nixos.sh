#!/bin/sh

set -ex

# Generate the hardware config.
nixos-generate-config --root /mnt

# Required during the installation process.
nix-env -i git

# 🚀
nixos-install
