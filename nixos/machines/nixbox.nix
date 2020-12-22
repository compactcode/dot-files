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
      };
    };

    kernelModules = [
      "kvm-intel"
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

    # Enable intel opengl hardware acceleration.
    opengl = {
      enable = true;

      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # Enable periodic trim for long term SSD performance.
  services.fstrim.enable = true;

  # Enable updating firmware via the command line.
  services.fwupd.enable = true;

  # Enable general power saving features.
  services.tlp = {
    enable = true;
  };

  services.xserver = {
    # Enable the proprietary NVIDIA drivers.
    videoDrivers = [ "nvidia" ];
  };

  networking = {
    hostName = "nixbox";
  };

  nix.maxJobs = lib.mkDefault 8;
}
