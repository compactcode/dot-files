{...}: {
  programs.nixvim = {
    # markdown viewer
    plugins.render-markdown = {
      enable = true;
      settings = {
        file_types = [
          "markdown"
          "codecompanion" # ai chat
        ];
      };

      # delay loading until opening a markdown file
      lazyLoad.settings.ft = [
        "markdown"
        "codecompanion" # ai chat
      ];
    };
  };
}
