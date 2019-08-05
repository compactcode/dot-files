{ config, lib, pkgs, ... }:

{
  imports = [
    ../configuration.nix
  ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  nix.maxJobs = lib.mkDefault 2;

  virtualisation.virtualbox.guest.enable = true;

  networking.hostName = "nixvm";
}