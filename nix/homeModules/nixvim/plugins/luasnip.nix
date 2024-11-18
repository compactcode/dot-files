{...}: {
  programs.nixvim = {
    # snippet engine
    plugins.luasnip = {
      enable = true;
      fromVscode = [
        {}
        {paths = ./snippets;}
      ];
    };
  };
}
