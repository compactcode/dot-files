{pkgs, ...}:
# CPU: Intel N100
# GPU: Intel UHD Graphics
# Motherboard: LarkBox X 2023
{
  boot = {
    initrd = {
      availableKernelModules = ["ahci" "sd_mod" "uas" "usb_storage" "usbhid" "xhci_pci"];
    };

    # enable virtualization
    kernelModules = ["kvm-intel"];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/sda1";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/sda2";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd"];
    };

    "/home" = {
      device = "/dev/sda2";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };

    "/nix" = {
      device = "/dev/sda2";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };

    "/swap" = {
      device = "/dev/sda2";
      fsType = "btrfs";
      options = ["subvol=swap" "noatime"];
    };

    "/mnt/nas/config" = {
      device = "192.168.1.200:/mnt/storage/config";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    "/mnt/nas/media" = {
      device = "192.168.1.200:/mnt/storage/media";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };

  swapDevices = [{device = "/swap/swapfile";}];

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
