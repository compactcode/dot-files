## My configuration for terminal based software development.

This is currently a [NixOS](https://nixos.org/nixos/) based configuration for VirtualBox.

### Requirements

* [VirtualBox 6](https://www.virtualbox.org/wiki/Downloads)
* [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
* [Packer](https://www.packer.io/)

### Installation

* `packer build packer.json`
  This will:
    - Create a new VirtualBox Machine configured with:
      - 6GB Memory
      - 16GB HDD
      - 2 Cpus
      - UEFI Firmware
      - KVM Virtualization
      - KVM Networking

    - Run `bin/prepare-uefi-filesystem.sh` to set up a the filsystem.
    - Copy the `nixos` configuration folder into the machine.
    - Run `bin/install-nixos.sh` to install NixOS.
