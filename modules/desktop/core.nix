{pkgs, ...}: {
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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    fonts = {
      emoji = {
        package = pkgs.nerdfonts.override {fonts = ["SourceCodePro"];};
        name = "Source Code Pro";
      };
    };
    image = ./wallpaper/mountain.jpg;
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
          ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
        };
      };
    };
  };
}
