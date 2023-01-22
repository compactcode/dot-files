{ pkgs, ... }:

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
      # Load the GPU early in the book process.
      "amdgpu"
    ];

    # Use the latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
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

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = 12;
    };
  };

  nixpkgs = {
    # Allow unfree programs to be installed.
    config = {
      allowUnfree = true;
    };
  };

  # Use English.
  i18n.defaultLocale = "en_US.UTF-8";

  # The timezone to Melbourne.
  time.timeZone = "Australia/Melbourne";

  # Set location to Melbourne.
  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  networking = {
    # Enable firewall.
    firewall = {
      enable = true;
    };

    # Detect and manage network connections.
    networkmanager = {
      enable = true;
    };
  };

  services = {
    # Primary source for graphical applications.
    flatpak = {
      enable = true;
    };

    # Enable support for yubikey.
    pcscd = {
      enable = true;
    };

    xserver = {
      enable = true;

      displayManager = {
        gdm.enable = true;
      };

      desktopManager = {
        gnome.enable = true;
      };

      # Turn caps lock into another ctrl.
      xkbOptions = "ctrl:nocaps";
    };
  };
  
  environment = {
    gnome = {
      excludePackages = with pkgs; [
        gnome.cheese
        gnome.gnome-maps
        gnome.gnome-music
        gnome.gnome-weather
        gnome.simple-scan
      ];
    };

    systemPackages = with pkgs; [
      bat # cat replacement.
      dnsutils # dns debugging.
      du-dust # du replacement.
      exa # ls replacement.
      fd # find replacement.
      fzf # fuzzy finder.
      git # version control.
      neovim # text editing.
      pciutils # pci debugging.
      podman-compose # docker compose for podman.
      ripgrep # grep replacement.
      usbutils # usb debugging.
      zig # c replacement.
    ];
  };

  # Setup users.
  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      root = {
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };

      shandogs = {
        extraGroups = [
          "wheel" # Enable sudo.
        ];
        isNormalUser = true;
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };

  programs = {
    # Password manager, installed here for access to the kernel keyring.
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [
        "shandogs"
      ];
    };

    # Web browser, installed here for access to the kernel keyring.
    firefox = {
      enable = true;
    };

    # Encryption, signing & authentication.
    gnupg = {
      agent = {
        enable = true;
        # Use yubikey for SHH via gpg.
        enableSSHSupport = true;
      };
    };
  };

  fonts = {
    # Install an nerd font for the icons.
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    ];
  };

  virtualisation = {
    # Docker like container engine.
    podman = {
      enable = true;
    };
  };

  # Enable flatpak apps to have system integration (dbus etc).
  xdg = {
    portal = {
      enable = true;
    };
  };

  system.stateVersion = "22.11";
}
