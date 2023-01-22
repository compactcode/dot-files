{ lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    _1password-gui # Password manager.
    mpv # Lightweight video player.
    sxiv # Lightweight image viewer.
    xclip # Clipboard access.
    zathura # Lightweight pdf viewer.
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
        "application/csv"        = "nvim.desktop";
        "application/pdf"        = "zathura.desktop";
        "image/jpeg"             = "sxiv.desktop";
        "image/jpg"              = "sxiv.desktop";
        "image/png"              = "sxiv.desktop";
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
