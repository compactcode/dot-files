{ pkgs, ... }:

# CPU: Intel Core i7-8565U
# GPU: Nvidia Quadro P520
# Motherboard: ThinkPad P43s

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci" ];

      luks.devices = {
        nixos-decrypted = {
          allowDiscards = true;
          device = "/dev/disk/by-uuid/?";
        };
      };
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/?";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/?";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/?";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/swap" = {
      device = "/dev/disk/by-uuid/?";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/?";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };
  };

  hardware = {
    # enable amd microcode updates
    cpu.intel.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # set a hostname
  networking.hostName = "prophet";

  # the version this machine was created with
  system.stateVersion = "22.11";
}
