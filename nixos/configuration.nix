{ lib, pkgs, ... }:

let
  settings = import ./settings.nix;

in {
  system.stateVersion = "20.09";

  imports = [
    <home-manager/nixos>
  ];

  nixpkgs = {
    overlays = [
      (import ./pkgs/default.nix)
    ];

    # Allow unfree programs to be installed.
    config = {
      allowUnfree = true;
    };
  };

  time.timeZone = "Australia/Melbourne";

  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  hardware = {
    # Enable sound.
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  networking = {
    # Enable firewall.
    firewall = {
      enable = true;
    };

    # Split development.
    hosts = {
      "127.0.0.1" = [
        "api.go.split.test"
        "go.split.test"
      ];
    };

    # Detect and manage network connections.
    networkmanager = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Command line utilities.
    dnsutils # dns debugging.
    ethtool # ethernet debugging.
    exfat # mount exfat drives.
    glxinfo # gfx debugging.
    libfido2 # fido2/webauthn authentication.
    lm_sensors # system sensor access.
    nfs-utils # mount nfs drives.
    pciutils # pci debugging.
    usbutils # usb debugging.
  ] ++ [
    # X11 utilities.

    arandr # Detect and manage multiple monitors.
    chromium # Web browser.
    firefox # Web browser.
    pavucontrol # Detect and manage audio devices.
  ];

  fonts = {
    fonts = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
      font-awesome
      (
        nerdfonts.override {
          fonts = [ "FiraCode"];
        }
      )
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif     = [ "Source Serif Pro" ];
      };
    };
  };

  services = {
    dbus = {
      enable = true;

      packages = with pkgs; [
        gnome3.dconf
      ];
    };

    # Backup in case native applications like Discord/Zoom break.
    flatpak = {
      enable = true;
    };

    # Opacity and drop shadows on windows.
    picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      inactiveOpacity = 0.950;
      opacityRules = [
        "100:class_g = 'Firefox'"
        "100:class_g = 'discord'"
        "100:class_g = 'zoom'"
      ];
      shadow = true;
      vSync = true;
    };

    # Enable support for gpg smart cards.
    pcscd = {
      enable = true;
    };

    # Postgres database for development.
    postgresql = {
      enable = true;

      package = pkgs.postgresql_12;

      # Enable passwordless local access.
      authentication = lib.mkForce ''
        local all all trust
        host all all ::1/128 trust
      '';
    };

    # Redis database for development.
    redis = {
      enable = true;
    };

    # Adjust screen color temperature based on the time of day.
    redshift = {
      enable = true;
    };

    xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        # Skip login since we just unlocked the encrypted drive.
        autoLogin = {
          enable = true;
          user = settings.user.username;
        };

        lightdm = {
          enable = true;
        };
      };

      windowManager = {
        i3 = {
          enable = true;
        };
      };

      # Turn caps lock into another ctrl.
      xkbOptions = "ctrl:nocaps";
    };
  };

  programs = {
    # Sandbox certain programs to mitigate damage from security breaches.
    firejail = {
      enable = true;

      wrappedBinaries = {
        firefox-sandboxed = "${lib.getBin pkgs.firefox}/bin/firefox";
      };
    };

    # Video games.
    steam = {
      enable = true;
    };
  };

  # Enable flatpak apps to have system integration (dbus etc).
  xdg = {
    portal = {
      enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;

    autoPrune = {
      enable = true;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      root = {
        hashedPassword = settings.user.hashedPassword;
      };

      ${settings.user.username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"          # Allow sudo.
          "video"          # Allow changing screen settings.
          "plugdev"        # Allow changing razer peripheral settings.
          "docker"         # Allow using docker.
          "networkmanager" # Allow changing network settings.
        ];
        hashedPassword = settings.user.hashedPassword;
      };
    };
  };

  # Automount NAS NFS volumes on demand.
  fileSystems = {
    "/nas/documents" = {
      device = "192.168.1.200:/mnt/storage/documents";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
    "/nas/media" = {
      device = "192.168.1.200:/mnt/storage/media";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
    "/nas/photos" = {
      device = "192.168.1.200:/mnt/storage/photos";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
  };

  home-manager.users.root = { pkgs, ... }: {
    nixpkgs = {
      overlays = [
        (import ./pkgs/default.nix)
      ];
    };

    imports = [
      ./home/terminal/basic.nix
    ];
  };

  home-manager.users.${settings.user.username} = { ... }: {
    nixpkgs = {
      overlays = [
        (import ./pkgs/default.nix)
      ];

      # Allow certain unfree programs to be installed.
      config = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "discord"
          "faac"
          "postman"
          "slack"
          "spotify"
          "spotify-unwrapped"
          "steam"
          "steam-original"
          "steam-runtime"
          "zoom"
        ];
      };
    };

    imports = [
      ./home/terminal/basic.nix
      ./home/desktop/basic.nix
      ./home/desktop/keys.nix
    ];
  };
}
