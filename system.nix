{ pkgs, ... }:

{
  boot = {
    loader = {
      # Allow displaying boot options.
      efi.canTouchEfiVariables = true;

      # Use system as the boot manager.
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };

    # Use the latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment = {
    gnome = {
      # Gnome packages I don't use.
      excludePackages = with pkgs; [
        gnome.cheese
        gnome.gnome-maps
        gnome.gnome-music
        gnome.gnome-weather
        gnome.simple-scan
      ];
    };

    systemPackages = with pkgs; [
      aws-vault # aws credential handling.
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
      xsv # csv viewer.
      zig # c replacement.
    ];
  };

  fonts = {
    # Install an nerd font for the icons.
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    ];
  };

  # Use English.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
        # Auto login since boot requires an encryption password.
        autoLogin = {
          enable = true;
          user = "shandogs";
        };
        gdm.enable = true;
      };

      desktopManager = {
        gnome.enable = true;
      };

      # Turn caps lock into another ctrl.
      xkbOptions = "ctrl:nocaps";
    };
  };

  system.stateVersion = "22.11";

  # The timezone to Melbourne.
  time.timeZone = "Australia/Melbourne";

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
}
