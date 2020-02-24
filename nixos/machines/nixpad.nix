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
      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
      };
    };

    # Used on newer thinkpads for tlp power saving.
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];

    # Used on newer thinkpads for tlp power saving.
    kernelModules = [
      "acpi_call"
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
    # Enable firmware for bluetooth/wireless (Intel® Wireless-AC 9560).
    enableRedistributableFirmware = true;

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

    nvidia = {
      # Prevent screen tearing.
      modesetting = {
        enable = true;
      };

      # Exclusively use the NVIDIA GPU.
      optimus_prime = {
        enable = true;
        nvidiaBusId = "PCI:60:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };

  # Enable periodic trim for long term SSD performance.
  services.fstrim.enable = true;

  # Enable updating firmware via the command line.
  services.fwupd.enable = true;

  # Enable cpu specific power saving features.
  services.thermald.enable = true;

  # Enable fix for lenovo cpu throttling issue.
  services.throttled.enable = true;

  # Enable general power saving features.
  services.tlp = {
    enable = true;
    extraConfig = ''
      CPU_SCALING_GOVERNOR_ON_AC=powersave
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
    '';
  };

  services.xserver = {
    # Enable touchpad support.
    libinput = {
      enable = true;
      accelSpeed = "0.5";
    };

    # Enable the proprietary NVIDIA drivers.
    videoDrivers = [ "nvidia" ];
  };

  networking = {
    hostName = "nixpad";
  };

  nix.maxJobs = lib.mkDefault 8;
}
