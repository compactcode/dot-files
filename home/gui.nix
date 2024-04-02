{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
  };

  programs = {
    kitty = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, n, exec, kitty"
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
