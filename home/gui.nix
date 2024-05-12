{
  pkgs,
  lib,
  ...
}: {
  programs = {
    # terminal
    kitty.enable = true;

    # application launcher
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # status bar
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top"; # display on top of other windows
          modules-left = [
            "hyprland/workspaces" # active workspaces
          ];
          modules-center = [
            "hyprland/window" # active window
          ];
          modules-right = [
            "temperature"
            "clock"
            "tray" # system tray
          ];
        };
      };
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
    };
  };

  services = {
    # notifications
    mako.enable = true;
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

  # window manager
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, e, exec, ~/.local/share/focusOrStart 2 kitty kitty"
        "$mod, f, fullscreen,"
        "$mod, n, exec, ~/.local/share/focusOrStart 1 firefox firefox"
        "$mod, k, exit,"
        "$mod, i, exec, rofi -show drun"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
      ];
    };
    # hyprland-session.target
    systemd.enable = true;
  };

  xdg = {
    dataFile = {
      # start or focus an application on a given workspace
      focusOrStart = {
        executable = true;
        text = ''
          #!/bin/sh

          address=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $1) | select(.class == \"$2\") | .address")

          hyprctl dispatch workspace $1

          if [[ $address == "" ]]; then
            $3
          else
            hyprctl dispatch focuswindow address:$address
          fi
        '';
      };
    };

    desktopEntries.nvim = {
      categories = ["Utility" "TextEditor"];
      exec = "${lib.getBin pkgs.kitty}/bin/kitty -e nvim";
      genericName = "Text Editor";
      icon = "nvim";
      name = "Neovim";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = ["nvim.desktop"];
        "text/markdown" = ["nvim.desktop"];
      };
    };
  };
}
