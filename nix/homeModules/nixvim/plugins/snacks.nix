{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>go";
        action = "<cmd>lua Snacks.gitbrowse()<cr>";
        mode = ["n" "v"];
        options = {desc = "open permalink url to current line(s)";};
      }
    ];

    # collection of plugins
    plugins.snacks = {
      enable = true;
      settings = {
        # git permalinks
        gitbrowse = {
          enable = true;
        };
        # upgrade input prompt
        input = {
          enable = true;
        };
      };
    };
  };
}
