{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./gui/email
    ./gui/wayland/hyprland
    ./gui/wayland/rofi
    ./gui/wayland/waybar
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

    # pdf viewer
    zathura.enable = true;
  };

  stylix = {
    targets = {
      gnome.enable = true; # ensure electron apps to detect system theme
      gtk.enable = true;
      kde.enable = true;
      kitty.enable = true;
      mako.enable = true;
      swaylock.enable = true;
      zathura.enable = true;
    };
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
        # TODO: Causes issues with swaylock and screen sharing.
        # {
        #   # power off screen after 15 minutes
        #   timeout = 60 * 15;
        #   command = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
        #   resumeCommand = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
        # }
      ];
    };
  };

  xdg = {
    # set base directories (config, state etc)
    enable = true;

    # add launcher for neovim
    desktopEntries.nvim = {
      categories = ["Utility" "TextEditor"];
      exec = "${lib.getExe pkgs.kitty} -e nvim";
      genericName = "Text Editor";
      icon = "nvim";
      name = "Neovim";
    };

    # set preferred applications
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
