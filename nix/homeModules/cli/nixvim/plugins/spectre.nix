{...}: {
  programs.nixvim = {
    # search and replace
    plugins.spectre = {
      enable = true;

      # delay loading until requested
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>cs";
          __unkeyed-2 = "<cmd>lua require(\"spectre\").open()<cr>";
          desc = "search and replace";
        }
      ];
    };
  };
}
