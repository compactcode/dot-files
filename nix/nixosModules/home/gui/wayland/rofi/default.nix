{pkgs, ...}: {
  home.packages = [
    # command line bookmark manager
    pkgs.buku
  ];

  programs = {
    # application launcher
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };

  xdg = {
    dataFile = {
      # open bookmark
      "rofi/bookmark.sh" = {
        executable = true;
        source = ./scripts/bookmark.sh;
      };

      # open project
      "rofi/project.sh" = {
        executable = true;
        source = ./scripts/project.sh;
      };
    };
  };
}