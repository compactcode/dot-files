{
  pkgs,
  lib,
  ...
}: {
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

    # video player
    mpv.enable = true;

    # application launcher
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # screen locker
    swaylock.enable = true;

    # status bar
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top"; # display on top of other windows
          spacing = 5;

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
            format = "{bandwidthUpBytes} {bandwidthDownBytes} 󰈀";
            interval = 10;
          };

          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-muted = "󰝟 {format_source}";
            format-icons = {
              headphone = "󰋋";
              muted-icon = "󰝟";
              default = ["󰕿" "󰖀" "󰕾"];
            };
            format-source = "{volume}% 󰍬";
            format-source-muted = " 󰍭";
            on-click = "pavucontrol";
            scroll-step = 5;
          };

          temperature = {
            format = "{temperatureC}°C 󰻠";
          };

          tray = {
            spacing = 5;
          };
        };
      };

      systemd.enable = true;
    };

    # wallpapers
    wpaperd.enable = true;

    # pdf viewer
    zathura.enable = true;
  };

  services = {
    # clipboard manager
    cliphist.enable = true;

    # notifications
    mako = {
      enable = true;
      # TODO: extract an option
      borderRadius = 5;
      # auto hide after 10 seconds
      defaultTimeout = 10 * 1000;
      # many application icons are ugly & unhelpful
      icons = false;
    };

    # idle detection
    swayidle = {
      enable = true;
      events = [
        {
          # hook into loginctl lock-session
          event = "lock";
          command = "${lib.getExe pkgs.swaylock} -f";
        }
        {
          # hook into systemctl suspend
          event = "before-sleep";
          command = "${lib.getExe pkgs.swaylock} -f";
        }
      ];
      timeouts = [
        {
          # lock screen after 10 minutes
          timeout = 60 * 10;
          command = "${lib.getExe pkgs.swaylock} -f";
        }
        {
          # power off screen after 15 minutes
          timeout = 60 * 15;
          command = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
          resumeCommand = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
        }
      ];
    };
  };

  systemd = {
    user.services = {
      # start wallpaper service when a desktop is launched
      wpaperd = {
        Unit = {
          Description = "wallpaper daemon";
          PartOf = ["graphical-session.target"];
        };
        Service = {
          ExecStart = "${lib.getExe pkgs.wpaperd}";
          Restart = "on-failure";
        };
        Install.WantedBy = ["graphical-session.target"];
      };
    };
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
        "$mod, p, exec, grimblast --notify edit area"
        "$mod, v, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

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

      bindm = [
        # move windows with left mouse
        "$mod, mouse:272, movewindow"
        # resize windows with right mouse
        "$mod, mouse:273, resizewindow"
      ];

      decoration = {
        # TODO: extract an option
        rounding = 5;
      };

      general = {
        gaps_out = 15;
      };

      misc = {
        disable_hyprland_logo = true;
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

          address=$(hyprctl clients -j | jq -r "map(select(.workspace.id == $1 and .class == \"$2\")) | .[0].address")

          if [[ $address == "null" ]]; then
            hyprctl dispatch exec [workspace "$1"] "$3"
          else
            hyprctl dispatch focuswindow address:"$address"
          fi
        '';
      };
    };

    desktopEntries.nvim = {
      categories = ["Utility" "TextEditor"];
      exec = "${lib.getExe pkgs.kitty} -e nvim";
      genericName = "Text Editor";
      icon = "nvim";
      name = "Neovim";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "image/gif" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";
        "image/tiff" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "inode/directory" = "yazi.desktop";
        "text/html" = "firefox.desktop";
        "text/markdown" = "nvim.desktop";
        "text/plain" = "nvim.desktop";
        "video/mp4" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/x-ms-wmv" = "mpv.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };

    # create default desktop directories
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
