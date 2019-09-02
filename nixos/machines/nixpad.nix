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

  # Enable intel microcode updates.
  hardware.cpu.intel.updateMicrocode = true;

  # Enable power saving mode.
  services.tlp.enable = true;

  services.xserver = {
    # Enable touchpad support.
    libinput = {
      enable = true;
      accelSpeed = "0.5";
    };

    videoDrivers = [
      "intel"
    ];
  };

  networking = {
    hostName = "nixpad";

    # Enable wireless support.
    wireless = {
      enable = true;
    };
  };

  nix.maxJobs = lib.mkDefault 8;
}
