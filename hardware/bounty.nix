{ pkgs, ... }:

# CPU: Intel Celeron J3455
# GPU: Intel HD Graphics 500
# Motherboard: Intel NUC Kit NUC6CAYS

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
      device = "/dev/disk/by-uuid/1260-EC22";
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

  swapDevices = [ { device = "/swap/swapfile"; } ];

  hardware = {
    # enable amd microcode updates
    cpu.intel.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # set a hostname
  networking = {
    hostName = "bounty";
    # enable the wireless card
    wireless.enable = true;
  };


  # the version this machine was created with
  system.stateVersion = "22.11";
}
