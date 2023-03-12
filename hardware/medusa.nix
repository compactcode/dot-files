{ pkgs, ... }:

# CPU: AMD Ryzen 5900X
# GPU: AMD Radeon 6700XT
# Motherboard: Gigabyte B550I AORUS PRO AX

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci" ];

      luks.devices = {
        nixos-decrypted = {
          allowDiscards = true;
          device = "/dev/disk/by-uuid/08942d85-69ce-4f84-a2fd-10dcf05e20c3";
        };
      };
    };

    # load the GPU early in the book process
    kernelModules = [ "amdgpu" ];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/E303-A443";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/96120c03-92c2-4635-b29e-d93e1b79a691";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/96120c03-92c2-4635-b29e-d93e1b79a691";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/96120c03-92c2-4635-b29e-d93e1b79a691";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };
  };

  hardware = {
    # enable amd microcode updates
    cpu.amd.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # set a hostname
  networking.hostName = "medusa";

  # the version this machine was created with
  system.stateVersion = "22.11";
}
