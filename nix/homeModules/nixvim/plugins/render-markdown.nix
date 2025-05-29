{...}: {
  programs.nixvim = {
    # markdown viewer
    plugins.render-markdown = {
      enable = true;
      # delay loading until opening a markdown file
      lazyLoad.settings.ft = "markdown";
    };
  };
}
