{ pkgs, lib, ... }:

{
  programs = {
    # terminal
    kitty.enable = true;
    # application launcher
    rofi.enable = true;
    # ssh client
    ssh = {
      enable = true;
      # use 1password as ssh agent
      extraConfig = ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
    };
    # status bar
    waybar = {
      enable = true;
      systemd.enable = true;
    };
  };

  # automatic theming
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ./wallpaper/mountain.jpg;
  };

  # window manager
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, n, exec, rofi -show drun"
        "$mod, e, exec, kitty"
        "$mod, i, exec, firefox"
        "$mod, k, exit,"
      ];
    };
  };

  xdg.desktopEntries.nvim = {
    categories = [ "Utility" "TextEditor" ];
    exec = "${lib.getBin pkgs.kitty}/bin/kitty -e nvim";
    genericName = "Text Editor";
    icon = "nvim";
    name = "Neovim";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
    };
  };
}
