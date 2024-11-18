{...}: {
  programs.nixvim = {
    # ui interfaces
    plugins.dressing = {
      enable = true;
      settings = {
        # upgrade input prompt
        input = {
          enable = true;
        };

        # upgrade input selection
        select = {
          enable = true;
          # use telescope to present options
          backend = [
            "telescope"
          ];
        };
      };
    };
  };
}
