{ lib, pkgs, ... }:

let
  settings = import ./settings.nix;

in {
  system.stateVersion = "19.03";

  imports = [
    <home-manager/nixos>
  ];

  nixpkgs = {
    overlays = [
      (import ./pkgs/default.nix)
    ];
  };

  time.timeZone = "Australia/Melbourne";

  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  hardware = {
    # Enable setting screen brightness.
    brightnessctl = {
      enable = true;
    };

    # Enable bluetooth support.
    bluetooth = {
      enable = true;
    };

    # Enable sound.
    pulseaudio = {
      enable = true;

      # Include bluetooth headphone support.
      package = pkgs.pulseaudioFull;
    };
  };

  # Detect and managing network connections.
  networking = {
    networkmanager = {
      enable = true;

      wifi = {
        powersave = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Command line utilities.

    bat # cat replacement.
    exa # ls replacement.
    fd # find replacement.
    fre # frequency/recency tracker.
    git # version control.
    lm_sensors # system sensor access.
    nfs-utils # mount nfs drives.
    pciutils # pci debugging.
    glxinfo # gfx debugging.
    ripgrep # grep replacement.
    skim # fuzzy finder.
    zsh # bash replacement.
    zsh-prezto # lightweight zsh framework.
  ] ++ [
    # X11 utilities.

    arandr # Detect and manage multiple monitors.
    arc-icon-theme # Arc icon theme for GTK appliactions.
    arc-theme # Arc theme for GTK appliactions.
    brightnessctl # Set screen brightness.
    firefox # Preferred web browser
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

    # A dummy desktop manager, we use .xsession instead.
    desktopManager = {
      default = "xterm";
    };

    displayManager.lightdm ={
      enable = true;

      # Skip login since we just unlocked the encrypted drive.
      autoLogin = {
        enable = true;
        user = settings.user.username;
      };
    };

    # Turn caps lock into another ctrl.
    xkbOptions = "ctrl:nocaps";
  };

  # Detect and managing bluetooth connections.
  services.blueman = {
    enable = true;
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

  # Adjust screen color temperature based on the time of day.
  services.redshift = {
    enable = true;
  };

  # Enable support for gpg smart cards.
  services.pcscd = {
    enable = true;
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
          "video" # Enable setting brightness without sudo.
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
