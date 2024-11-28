{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.darwinModules.stylix
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shanon = {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            inputs._1password-shell-plugins.hmModules.default
            inputs.self.homeModules.cli-core
            inputs.self.homeModules.cli-development
            inputs.self.homeModules.nixvim
          ];
          home = {
            stateVersion = "24.05";
          };
          programs.kitty.enable = true;
          stylix.targets.kitty.enable = true;
        };
      };
    }
    {
      # configure user
      users.users.shanon = {
        name = "shanon";
        home = "/Users/shanon";
      };

      system.keyboard = {
        # allow remap
        enableKeyMapping = true;
        # remap capslock to control
        remapCapsLockToControl = true;
      };

      # enable touch id for sudo
      security.pam.enableSudoTouchIdAuth = true;

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

        image = ./wallpaper/space.jpg;

        # dark mode
        polarity = "dark";
      };
    }
  ];
}
