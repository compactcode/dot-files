{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  environment = {
    systemPackages = with pkgs; [
      adwaita-icon-theme # gnome icons
      armcord # voice chat (discord)
      bruno # api explorer
      dust # du replacement
      grimblast # screenshot taker
      obsidian # document manager
      pavucontrol # sound manager
      pinta # image editor
      signal-desktop # secure messenger
      slack # messenger
      wl-clipboard # clipboard interaction
      xsv # csv explorer
    ];

    sessionVariables = {
      # default nix electron apps to use wayland
      NIXOS_OZONE_WL = 1;
      # default obsidian to use wayland
      OBSIDIAN_USE_WAYLAND = 1;
      # send grimblast screenshots to pinta
      GRIMBLAST_EDITOR = "pinta";
    };
  };

  programs = {
    # password manager
    _1password.enable = true;

    # password manager gui, installed here over flatpak for access to the kernel keyring
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["shandogs"];
    };

    # web browser, installed here over flatpak for access to the kernel keyring
    firefox.enable = true;
  };

  # enable real-time scheduling for pipewire
  security.rtkit.enable = true;

  services = {
    # alternate source for graphical applications
    flatpak.enable = true;

    # enable sound via pipewire
    pipewire = {
      enable = true;
      # pulseaudio compatibility
      pulse.enable = true;
    };
  };

  # automatic theming
  stylix = {
    enable = true;

    autoEnable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["SourceCodePro"];};
        name = "Sauce Code Pro Nerd Font";
      };

      sansSerif = {
        package = pkgs.rubik;
        name = "Rubik";
      };

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
    };

    image = ./wallpaper/space.jpg;

    opacity = {
      # give terminals a transparent background
      terminal = 0.9;
    };

    # dark mode
    polarity = "dark";

    # automatic styling
    targets = {
      # boot console
      console.enable = true;
      # cant be done in home manager
      chromium.enable = true;
    };
  };

  systemd = {
    user.services = {
      # start 1password so applications can make requests
      _1password = {
        description = "1password";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${lib.getExe' pkgs._1password-gui "1password"} --silent";
        };
      };
    };
  };

  virtualisation = {
    # container manager
    docker = {
      enable = true;
      # start on demand
      enableOnBoot = false;
    };
  };
}
