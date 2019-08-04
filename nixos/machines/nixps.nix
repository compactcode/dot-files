{ config, lib, pkgs, ... }:

{
  imports = [
    ../configuration.nix
  ];

  boot.initrd.availableKernelModules = [];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  nix.maxJobs = lib.mkDefault 4;

  networking.hostName = "nixps";
}
