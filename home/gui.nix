{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = [
      pkgs.bruno # api explorer
      pkgs.obsidian # document manager
      pkgs.slack # messenger
      pkgs.vesktop # voice chat (discord)
    ];

    sessionVariables = {
      # default nix electron apps to use wayland
      NIXOS_OZONE_WL = 1;
      # default obsidian to use wayland
      OBSIDIAN_USE_WAYLAND = 1;
    };
  };

  # gtk syles
  gtk.enable = true;

  programs = {
    # backup browser for websites that don't work in firefox
    chromium = {
      enable = true;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };

    # image viewer
    imv.enable = true;

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
            "clock"
          ];
          modules-right = [
            "temperature"
            "pulseaudio" # sound
            "tray" # system tray
          ];
        };
      };
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
    };

    # pdf viewer
    zathura.enable = true;
  };

  services = {
    # notifications
    mako.enable = true;

  };

  # window manager
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      bind = [
        # applications tied to particular workspaces
        "$mod, d, exec, ~/.local/share/focusOrStart 5 vesktop vesktop"
        "$mod, e, exec, ~/.local/share/focusOrStart 3 kitty kitty"
        "$mod, n, exec, ~/.local/share/focusOrStart 1 firefox firefox"
        "$mod, o, exec, ~/.local/share/focusOrStart 4 obsidian obsidian"
        "$mod, r, exec, ~/.local/share/focusOrStart 5 Slack slack"
        "$mod, s, exec, ~/.local/share/focusOrStart 2 kitty kitty"

        # applications
        "$mod, i, exec, rofi -show drun"
        "$mod, b, exec, kitty yazi"
        "$mod, t, exec, kitty"

        # focused window actions
        "$mod, f, fullscreen,"
        "$mod, w, togglefloating,"
        "$mod, q, killactive,"

        # focus windows
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # open workspaces
        "$mod, TAB, workspace, previous"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # move windows
        "$mod+Shift, 1, movetoworkspace, 1"
        "$mod+Shift, 2, movetoworkspace, 2"
        "$mod+Shift, 3, movetoworkspace, 3"
        "$mod+Shift, 4, movetoworkspace, 4"
        "$mod+Shift, 5, movetoworkspace, 5"
        "$mod+Shift, 6, movetoworkspace, 6"
        "$mod+Shift, 7, movetoworkspace, 7"
        "$mod+Shift, 8, movetoworkspace, 8"
        "$mod+Shift, 9, movetoworkspace, 9"
      ];

      windowrulev2 = [
        "workspace 5, class:^(Slack)$"
        "workspace 9, class:^(steam)$"
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
        "application/pdf" = ["zathura.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/png" = ["imv.desktop"];
        "image/svg+xml" = ["imv.desktop"];
        "image/tiff" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "text/html" = ["firefox.desktop"];
        "text/markdown" = ["nvim.desktop"];
        "text/plain" = ["nvim.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
      };
    };
  };
}
