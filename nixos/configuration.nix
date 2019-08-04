{ pkgs, ... }:

let
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

  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };
    systemd-boot = {
      enable = true;
    };
  };

  time.timeZone = "Australia/Melbourne";

  hardware.pulseaudio = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    bat     # cat replacement
    exa     # ls replacement
    fd      # find replacement
    feh     # required to set desktop background
    firefox
    git
    ripgrep # grep replacement
    zsh     # bash replacement
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
        user   = "shandogs";
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

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      root = {
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };

      shandogs = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
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

  home-manager.users.shandogs = { pkgs, ... }: {
    nixpkgs = {
      overlays = [
        (import ./pkgs/default.nix)
      ];
    };

    imports = [
      ./home/terminal/basic.nix
      ./home/terminal/development.nix
      ./home/desktop/basic.nix
    ];

    home.file.".background-image".source = pkgs.copyPathToStore ./art/wallpaper-coffee-3840x2560.jpg;
  };
}
