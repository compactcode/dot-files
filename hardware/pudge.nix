{ pkgs, ... }:

# CPU: Intel N100
# GPU: Intel UHD Graphics
# Motherboard: LarkBox X 2023

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "ahci" "sd_mod" "uas" "usb_storage" "usbhid" "xhci_pci" ];
    };

    # enable virtualization
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/?";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/b7b61f4f-847d-46d5-9700-08082960b2ef";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/b7b61f4f-847d-46d5-9700-08082960b2ef";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/b7b61f4f-847d-46d5-9700-08082960b2ef";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

    "/swap" = {
      device = "/dev/disk/by-uuid/b7b61f4f-847d-46d5-9700-08082960b2ef";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];

  hardware = {
    # enable amd microcode updates
    cpu.intel.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # set a hostname
  networking = {
    hostName = "pudge";
    # enable the wireless card
    wireless = {
      enable = true;
      # allow dynamic network selection
      userControlled.enable = true;
    };
  };

  # the version this machine was created with
  system.stateVersion = "23.05";
}
