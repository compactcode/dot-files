{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<cr>";
        options = {desc = "preview hunk";};
      }
      {
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<cr>";
        options = {desc = "reset hunk";};
      }
    ];

    # git decorations
    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
      };
    };
  };
}
