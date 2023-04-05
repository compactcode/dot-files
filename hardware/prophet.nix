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
          device = "/dev/disk/by-uuid/faf3866c-2bdb-4b87-a9d0-96bb2271f294";
        };
      };
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/2FC2-5199";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/swap" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
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

  # set a swap file
  swapDevices = [{ device = "/swap/swapfile"; }];

  # the version this machine was created with
  system.stateVersion = "22.11";
}
