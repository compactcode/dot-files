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
      # open bookmark browser
      openBookmark = {
        executable = true;
        source = ./scripts/openBookmark.sh;
      };
    };
  };
}
