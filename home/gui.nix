{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = [
      pkgs.bruno # api explorer
      pkgs.grimblast # screenshot taker
      pkgs.obsidian # document manager
      pkgs.pinta # image editor
      pkgs.pavucontrol # sound manager
      pkgs.slack # messenger
      pkgs.vesktop # voice chat (discord)
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
            "hyprland/submap" # active keybind mode
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "temperature"
            "network"
            "pulseaudio" # sound
            "tray" # system tray
          ];

          clock = {
            format = "{:%H.%M}";
            tooltip = true;
            tooltip-format = "{:%d.%m.%Y}";
          };

          network = {
            interval = 10;
            format = "{bandwidthUpBytes} {bandwidthDownBytes}";
          };
        };
      };

      systemd.enable = true;
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
        "$mod, p, exec, grimblast edit area"

        # focused window actions
        "$mod, f, fullscreen,"
        "$mod, w, togglefloating,"
        "$mod, q, killactive,"

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

      decoration = {
        rounding = 5;
      };

      general = {
        gaps_out = 15;
      };

      misc = {
        disable_splash_rendering = true;
      };

      windowrulev2 = [
        "workspace 5, class:^(Slack)$"
        "workspace 9, class:^(steam)$"
      ];
    };

    extraConfig = ''
      bind = $mod, u, submap, motions

      submap = motions

      # focus windows
      bind = , left, movefocus, l
      bind = , right, movefocus, r
      bind = , up, movefocus, u
      bind = , down, movefocus, d

      # resize windows
      binde = CTRL, right, resizeactive, 10 0
      binde = CTRL, left, resizeactive, -10 0
      binde = CTRL, up, resizeactive, 0 -10
      binde = CTRL, down, resizeactive, 0 10

      # move windows
      bind = SHIFT, left, movewindow, l
      bind = SHIFT, right, movewindow, r
      bind = SHIFT, up, movewindow, u
      bind = SHIFT, down, movewindow, d

      bind = , escape, submap, reset

      submap = reset
    '';

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

    # create default desktop directories
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
