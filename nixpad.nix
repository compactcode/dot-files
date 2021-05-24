{ lib, pkgs, ... }:

{
  imports = [
    ./hardware/core.nix
    ./hardware/intel-cpu.nix
  ];

  system.stateVersion = "20.09";

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
      ];

      luks.devices = {
        nixos-decrypted = {
          allowDiscards = true;
          device = "/dev/disk/by-partlabel/primary";
        };
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  networking = {
    hostName = "nixpad";
  };

  nix.maxJobs = lib.mkDefault 8;
}
