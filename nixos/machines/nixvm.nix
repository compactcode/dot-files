{ config, lib, pkgs, ... }:

{
  imports = [
    ../configuration-lite.nix
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
        nixos-decrypted = {
          device = "/dev/disk/by-partlabel/primary";
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
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  nix.maxJobs = lib.mkDefault 2;

  virtualisation.virtualbox.guest.enable = true;

  networking.hostName = "nixvm";
}
