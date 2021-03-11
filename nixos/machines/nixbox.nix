{ config, lib, pkgs, ... }:

{
  imports = [
    ../configuration.nix
  ];

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

      luks.devices."nixos-decrypted" = {
        device = "/dev/disk/by-partlabel/primary";
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

    kernelModules = [
      "kvm-intel"
    ];

    # Eliminate coil whine while idle.
    kernelParams = [
      "intel_idle.max_cstate=1"
    ];

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

  hardware = {
    # Enable intel microcode updates.
    cpu.intel.updateMicrocode = true;
  };

  # Enable periodic trim for long term SSD performance.
  services.fstrim.enable = true;

  # Enable general power saving features.
  services.tlp = {
    enable = true;

    # The GRACE SDAC doesn't support USB autosuspend.
    settings = {
      USB_BLACKLIST = "21b4:0144";
    };
  };

  services.xserver = {
    # Enable the proprietary NVIDIA drivers.
    videoDrivers = [ "nvidia" ];

    # The external monitor was not being selected as primary.
    xrandrHeads = [
      {
        output = "DP-2";
        primary = true;
      }
    ];
  };

  networking = {
    hostName = "nixbox";
  };

  nix.maxJobs = lib.mkDefault 8;
}
