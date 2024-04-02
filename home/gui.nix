{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
  };

  programs = {
    kitty.enable = true;
    rofi.enable = true;
    waybar = {
      enable = true;
      systemd.enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, n, exec, rofi"
        "$mod, e, exec, kitty"
        "$mod, i, exec, firefox"
        "$mod, k, exit,"
      ];
    };
  };

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ./wallpaper/mountain.jpg;
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
