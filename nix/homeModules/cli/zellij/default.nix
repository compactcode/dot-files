{
  xdg = {
    configFile = {
      # generic project
      "zellij/layouts/basic.kdl" = {
        source = ./layouts/basic.kdl;
      };
      # devenv project
      "zellij/layouts/devenv.kdl" = {
        source = ./layouts/devenv.kdl;
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
        keybinds = {
          unbind = [
            # disable session mode (conflicts with neovim)
            "Ctrl o"
            # disable tmux mode (conflicts with neovim)
            "Ctrl b"
          ];
          normal = {
            # disable resize mode (conflicts with neovim)
            unbind = ["Ctrl n"];
          };
        };
      };
    };
  };

  # automatic styling
  stylix = {
    targets = {
      zellij.enable = true;
    };
  };
}
