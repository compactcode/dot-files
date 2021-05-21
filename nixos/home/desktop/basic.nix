{ lib, pkgs, ... }:

let
  settings = import ../../settings.nix;
  theme = import ../themes/base_16_current.nix;

in {
  imports = [
    ./basic/alacritty.nix
    ./basic/i3.nix
    ./basic/rofi.nix
  ];

  home.packages = with pkgs; [
    discord # Voice communication.
    mpv # Lightweight video player.
    xclip # Clipboard access.
    pinta # Lightweight image editor.
    postman # API interaction.
    signal-desktop # Text communication.
    slack # Text communication.
    spotify # Music player.
    sxiv # Lightweight image viewer.
    zathura # Lightweight pdf viewer.
    zoom-us # Video communication.
  ];

  xdg.configFile."sxiv/exec/key-handler" = {
    executable = true;
    text = ''
      #!/bin/sh
      case "$1" in
      "C-x") xclip -in -filter | tr '\n' ' ' | xclip -in -selection clipboard ;;
      esac
    '';
  };

  # Ensure config gets propogated to user services.
  xsession = {
    enable = true;
  };

  # Create common user dirs.
  xdg = {
    mime = {
      enable = true;
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/csv"        = "nvim.desktop";
        "application/pdf"        = "zathura.desktop";
        "image/jpeg"             = "sxiv.desktop";
        "image/jpg"              = "sxiv.desktop";
        "image/png"              = "sxiv.desktop";
        "inode/directory"        = "lf.desktop";
        "text/plain"             = "nvim.desktop";
        "x-scheme-handler/http"  = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
  };

  services = {
    # Display desktop notfications.
    dunst = {
      enable = true;

      settings = {
        global = {
          follow = "keyboard"; # Show notifications where the keyboard has foucs.
          font = "${settings.font.sansFamily} ${settings.font.defaultSize.points}";
          format = "<b>%s</b>\\n%b";
          frame_width = 2; # Border size.
          geometry = "400x5-18+42"; # Size & location of notifications.
          horizontal_padding = 6;
          markup = "yes"; # Enable basic markup in messages.
          max_icon_size = 32; # Put a limit on image/icon size.
          padding = 6; # Vertical padding
          separator_color = "frame"; # Match to the frame color.
          separator_height = 2; # Space between notifications.
          sort = "yes"; # Sort messages by urgency.
        };

        urgency_low = {
          background = theme.base00-hex;
          foreground = theme.base04-hex;
          frame_color = theme.base03-hex;
          timeout = 4;
        };

        urgency_normal = {
          background = theme.base00-hex;
          foreground = theme.base04-hex;
          frame_color = theme.base0A-hex;
          timeout = 6;
        };

        urgency_critical = {
          background = theme.base00-hex;
          foreground = theme.base04-hex;
          frame_color = theme.base0B-hex;
          timeout = 10;
        };
      };
    };

    # Add the network manager to the status bar.
    network-manager-applet = {
      enable = true;
    };

    # Add the audio manager to the status bar.
    pasystray = {
      enable = true;
    };

    # Set a background image.
    random-background = {
      enable = true;
      imageDirectory = toString ./art;
    };

    # Manage removeable media.
    udiskie = {
      enable = true;
      tray = "auto";
    };
  };
}
