{...}: {
  programs.nixvim = {
    # file explorer
    plugins.oil = {
      enable = true;

      settings = {
        # dont prompt when making non destructive changes
        skip_confirm_for_simple_edits = true;
        view_options = {
          # show files and directories starting with "."
          show_hidden = true;
        };
      };

      # delay loading until requested
      lazyLoad.settings = {
        cmd = "Oil";
        keys = [
          {
            __unkeyed-1 = "<leader>e";
            __unkeyed-2 = "<cmd>Oil<cr>";
            desc = "explore files";
          }
        ];
      };
    };
  };
}
