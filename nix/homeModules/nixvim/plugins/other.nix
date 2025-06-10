{pkgs, ...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>o";
        action = "<cmd>Other<cr>";
        options = {desc = "open alternate file";};
      }
    ];

    # find related files
    extraPlugins = [
      pkgs.vimPlugins.other-nvim
    ];

    extraConfigLua = ''
      require("other-nvim").setup({
        mappings = {
          "rails",
        },
      })
    '';
  };
}
