{ pkgs, ... }:

let
  settings = import ./settings.nix;
  theme = import ./home/themes/base_16_current.nix;

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
    };
  };

  environment.systemPackages = with pkgs; [
    # Command line utilities.

    # cat replacement.
    bat
    # ls replacement.
    exa
    # find replacement.
    fd
    # frequency/recency tracker.
    fre
    # version control.
    git
    # top replacement.
    htop
    # grep replacement.
    ripgrep
    # fuzzy finder
    skim
    yubikey-personalization
    # bash replacement.
    zsh
    # lightweight zsh framework.
    zsh-prezto
  ] ++ [
    # X11 utilities.

    # Detect and manage multiple monitors.
    arandr
    # Arc theme for GTK appliactions.
    arc-theme
    arc-icon-theme
    # Detect and manage bluetooth connections.
    blueman
    # Set screen brightness.
    brightnessctl
    # Set background images.
    feh
    # Detect and apply themes for GTK applications.
    lxappearance-gtk3
    # Detect and manage audio devices.
    pavucontrol
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
      default = "none";

      xterm = {
        enable = false;
      };

      wallpaper = {
        mode = "fill";
      };
    };

    displayManager.lightdm ={
      enable = true;

      greeters.mini = {
        enable = true;
        user = settings.user.username;
        extraConfig = ''
          [greeter-theme]
          background-image = ""
          background-color = "${theme.base00-hex}"
          window-color = "${theme.base03-hex}"
          border-color = "${theme.base01-hex}"
          text-color = "${theme.base05-hex}"
          error-color = "${theme.base0C-hex}"
        '';
      };
    };

    windowManager = {
      default = "i3";

      i3 = {
        enable = true;

        package = pkgs.i3-gaps;

        extraPackages = with pkgs; [
          i3status-rust
        ];
      };
    };

    # Turn caps lock into another ctrl.
    xkbOptions = "ctrl:nocaps";
  };

  services.compton = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    activeOpacity = "0.95";
    inactiveOpacity = "0.85";
    opacityRules = [
      "99:class_g = 'Firefox'"
    ];
  };

  # Adjust screen color temperature based on the time of day.
  services.redshift = {
    enable = true;
    latitude = "-37.814";
    longitude = "144.96332";
  };

  # Enable support for gpg smart cards.
  services.pcscd = {
    enable = true;
  };

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  programs = {
    # Add the network manager applet to the i3 bar tray.
    nm-applet = {
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
          "video" # Enable setting brightness without sudo.
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
      ./home/desktop/basic.nix
      ./home/desktop/general.nix
      ./home/desktop/security.nix
    ];
  };
}
