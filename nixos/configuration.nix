{ lib, pkgs, ... }:

let
  settings = import ./settings.nix;

in {
  system.stateVersion = "20.03";

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

  # Detect and managing network connections.
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Command line utilities.

    bat # cat replacement.
    exa # ls replacement.
    fd # find replacement.
    fre # frequency/recency tracker.
    git # version control.
    glxinfo # gfx debugging.
    lm_sensors # system sensor access.
    exfat # mount exfat drives.
    nfs-utils # mount nfs drives.
    pciutils # pci debugging.
    ripgrep # grep replacement.
    skim # fuzzy finder.
    zsh # bash replacement.
    zsh-prezto # lightweight zsh framework.
  ] ++ [
    # X11 utilities.

    arandr # Detect and manage multiple monitors.
    arc-icon-theme # Arc icon theme for GTK appliactions.
    arc-theme # Arc theme for GTK appliactions.
    firefox # Preferred web browser.
    lxappearance-gtk3 # Detect and apply themes for GTK applications.
    pavucontrol # Detect and manage audio devices.
  ];

  fonts = {
    fonts = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
      font-awesome_4
      font-awesome_5
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif     = [ "Source Serif Pro" ];
      };
    };
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      lightdm = {
        enable = true;

        # Skip login since we just unlocked the encrypted drive.
        autoLogin = {
          enable = true;
          user = settings.user.username;
        };
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

  # Opacity and drop shadows on windows.
  services.compton = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    activeOpacity = "0.975";
    inactiveOpacity = "0.950";
    opacityRules = [
      "99:class_g = 'Firefox'"
    ];
  };

  # Redis database for development.
  services.redis = {
    enable = true;
  };

  # Adjust screen color temperature based on the time of day.
  services.redshift = {
    enable = true;
  };

  # Enable support for gpg smart cards.
  services.pcscd = {
    enable = true;
  };

  # Postgres database for development.
  services.postgresql = {
    enable = true;
    ensureUsers = [{
      name = settings.user.username;
      ensurePermissions = {
        "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
      };
    }];
  };

  programs = {
    # Add the network manager to the status bar.
    nm-applet = {
      enable = true;
    };
  };

  # Sandbox certain programs to mitigate damage from security breaches.
  programs.firejail = {
    enable = true;

    wrappedBinaries = {
      firefox-sandboxed = "${lib.getBin pkgs.firefox}/bin/firefox";
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
          "networkmanager" # Enable changing network settings without sudo.
        ];
        hashedPassword = settings.user.hashedPassword;
      };
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
        allowUnfreePredicate = pkg: builtins.elem (pkg.pname) [
          "slack"
        ];
      };
    };

    imports = [
      ./home/terminal/basic.nix
      ./home/terminal/development.nix
      ./home/terminal/email.nix
      ./home/terminal/files.nix
      ./home/desktop/basic.nix
      ./home/desktop/keys.nix
      ./home/desktop/general.nix
      ./home/desktop/security.nix
    ];
  };
}
