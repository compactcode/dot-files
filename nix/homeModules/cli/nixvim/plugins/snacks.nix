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

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
