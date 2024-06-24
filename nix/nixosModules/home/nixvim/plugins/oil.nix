{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>o";
        action = "<cmd>Oil<cr>";
        options = {desc = "explore files";};
      }
    ];

    # file explorer
    plugins.oil = {
      enable = true;
      settings = {
        # dont prompt when making non destructive changes
        skip_confirm_for_simple_edits = true;
      };
    };
  };
}
