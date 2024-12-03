{pkgs, ...}: {
  # automatic theming
  stylix = {
    enable = true;

    autoEnable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

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

    # required but not used
    image = ./wallpaper/space.jpg;

    # dark mode
    polarity = "dark";
  };

  system = {
    defaults = {
      dock = {
        # only show on hover
        autohide = true;
        # only pin these apps
        persistent-apps = [
          "/Applications/Google Chrome.app"
          "/System/Applications/Mail.app"
          "${pkgs.kitty}/Applications/Kitty.app"
          "${pkgs.slack}/Applications/Slack.app"
        ];
      };
    };
    keyboard = {
      # allow remap
      enableKeyMapping = true;
      # remap capslock to control
      remapCapsLockToControl = true;
    };
  };

  # enable touch id for sudo
  security.pam.enableSudoTouchIdAuth = true;
}
