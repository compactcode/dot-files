{...}: {
  programs.nixvim = {
    # collection of plugins
    plugins.snacks = {
      enable = true;
      settings = {
        # upgrade input prompt
        input = {
          enable = true;
        };
      };
    };
  };
}
