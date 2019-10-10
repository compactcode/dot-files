## Running inside VirtualBox

Some basic details on how to set up a virtual machine for testing.

The hardware specific configuration [lives here](../nixos/machines/nixvm.nix).

### Issues

I'm still running a 4.x kernel as the automatic upgrade did not work and was not a priority.

## Requirements

* [VirtualBox 6](https://www.virtualbox.org/wiki/Downloads)
* [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
* [Packer](https://www.packer.io/)

## Installation

* `packer build packer.json`
  This will:
    - Create a new VirtualBox Machine configured with:
      - 4GB Memory
      - 16GB HDD
      - 2 Cpus
      - UEFI Firmware
      - KVM Virtualization
      - KVM Networking

    - Run `bin/prepare-uefi-filesystem.sh` to set up the filsystem.
    - Copy the `nixos` configuration folder into the machine.
    - Run `bin/install-nixos.sh` to install NixOS.

This will build an ovf image that you can mount/launch in the `output-virtualbox-iso` directory.

After booting up you can login using the default password `secret`.
