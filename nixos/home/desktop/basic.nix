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
    libreoffice # Spreadsheet & word documents.
    mpv # Lightweight video player.
    pinta # Lightweight image editor.
    postman # API interaction.
    signal-desktop # Text communication.
    slack # Text communication.
    spotify # Music player.
    steam # Video games.
    sxiv # Lightweight image viewer.
    zathura # Lightweight pdf viewer.
    zoom-us # Video communication.
  ];

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
        "application/pdf"        = "zathura.desktop";
        "image/jpeg"             = "sxiv.desktop";
        "image/png"              = "sxiv.desktop";
        "x-scheme-handler/http"  = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };

    userDirs = {
      enable = true;
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

  programs = {
    astroid = {
      enable = true;
      pollScript = ''
        ${lib.getBin pkgs.isync}/bin/mbsync -a
        ${lib.getBin pkgs.notmuch}/bin/notmuch new
      '';
    };
  };

  services = {
    # Display desktop notfications.
    dunst = {
      enable = true;

      settings = {
        global = {
          follow = "keyboard"; # Show notifications where the keyboard has foucs.
          format = "<b>%s</b>\\n%b";
          font = "${settings.font.sansFamily} ${settings.font.defaultSize.points}";
          frame_width = 2; # Border size.
          geometry = "400x5-18+42"; # Size & location of notifications.
          horizontal_padding = 6;
          markup = "yes"; # Enable basic markup in messages.
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

    # Add an audio effects manager.
    pulseeffects = {
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
