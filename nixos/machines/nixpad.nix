{ config, lib, pkgs, ... }:

{
  imports = [
    ../configuration.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
      ];

      luks.devices."nixos-decrypted" = {
        device = "/dev/disk/by-partlabel/primary";
      };
    };

    loader = {
      systemd-boot = {
        enable = true;
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  hardware.cpu.intel.updateMicrocode = true;

  nix.maxJobs = lib.mkDefault 8;

  networking.hostName = "nixpad";
}
