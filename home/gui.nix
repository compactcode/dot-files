{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./gui/email
    ./gui/wayland/rofi
    ./gui/wayland/hyprland
  ];

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

    # network manager
    network-manager-applet.enable = true;

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

  xdg = {
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
      extraConfig = {
        XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      };
    };
  };
}
