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
    # Steam support
    opengl = {
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      driSupport32Bit = true;
    };

    # Enable sound.
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };

  networking = {
    # Split development.
    hosts = {
      "127.0.0.1" = [ "api.split.test" "go.split.test" ];
    };

    # Detect and manage network connections.
    networkmanager = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Command line utilities.
    exfat # mount exfat drives.
    ethtool # ethernet debugging.
    glxinfo # gfx debugging.
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

    # Opacity and drop shadows on windows.
    picom = {
      enable = true;
      fade = true;
      fadeDelta = 5;
      shadow = true;
      inactiveOpacity = 0.950;
      opacityRules = [
        "100:class_g = 'Firefox'"
      ];
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

  # Sandbox certain programs to mitigate damage from security breaches.
  programs.firejail = {
    enable = true;

    wrappedBinaries = {
      firefox-sandboxed = "${lib.getBin pkgs.firefox}/bin/firefox";
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
          "wheel" # Enable sudo.
          "video" # Enable changing screen settings without sudo.
          "docker" # Enable using docker without sudo.
          "networkmanager" # Enable changing network settings without sudo.
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
          "slack"
          "spotify"
          "steam"
          "steam-original"
          "steam-runtime"
          "zoom-us"
        ];
      };
    };

    imports = [
      ./home/terminal/basic.nix
      ./home/desktop/basic.nix
      ./home/desktop/keys.nix
      ./home/desktop/security.nix
    ];
  };
}
