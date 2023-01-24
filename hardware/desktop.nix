{ pkgs, ... }:

# CPU: Ryzen 5900X
# GPU: Radeon 6700XT
# Motherboard: B550I AORUS PRO AX

{
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];

      luks.devices = {
        nixos-decrypted = {
          allowDiscards = true;
          device = "/dev/disk/by-partlabel/primary";
        };
      };
    };

    kernelModules = [
      # Load the GPU early in the book process.
      "amdgpu"
    ];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
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
    # Enable amd microcode updates.
    cpu.amd.updateMicrocode = true;

    # Enable nonfree firmware.
    enableRedistributableFirmware = true;
  };

  networking = {
    # Set a hostname.
    hostName = "medusa";
  };
}
