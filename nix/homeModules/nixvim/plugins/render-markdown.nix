{...}: {
  programs.nixvim = {
    # markdown viewer
    plugins.render-markdown = {
      enable = true;
    };
  };
}
