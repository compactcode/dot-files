{ config, lib, pkgs, ... }:

{
  imports = [
    ../configuration.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "ahci"
        "sd_mod"
        "sr_mod"
      ];

      luks.devices = {
        unlocked = {
          device = "/dev/disk/by-partlabel/primary";
          preLVM = true;
        };
      };
    };

    loader = {
      systemd-boot = {
        enable = true;
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/unlocked-lvm/nixos";
    fsType = "ext4";
  };

  nix.maxJobs = lib.mkDefault 2;

  virtualisation.virtualbox.guest.enable = true;

  networking.hostName = "nixvm";
}
