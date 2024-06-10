{
  xdg = {
    configFile = {
      # basic project template
      "zellij/layouts/project.kdl" = {
        source = ./layouts/project.kdl;
      };
    };
  };

  programs = {
    # workspace manager
    zellij = {
      enable = true;
      settings = {
        # simple ui
        default_layout = "compact";
        # remove internal borders
        pane_frames = false;
      };
    };
  };
}
