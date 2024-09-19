{...}: {
  programs.nixvim = {
    # language parsing
    plugins = {
      treesitter = {
        enable = true;
        # highlight embedded lua
        nixvimInjections = true;
        settings = {
          # replace default highlighting
          highlight.enable = true;
          # replace default indenting
          indent.enable = true;
        };
      };
      # language query extensions (used by mini.ai)
      treesitter-textobjects = {
        enable = true;
        # use mini.ai instead
        select.enable = false;
      };
    };
  };
}
