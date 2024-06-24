{pkgs, ...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "gn";
        action = "<cmd>AerialNext<cr>";
        options = {desc = "jump to next symbol";};
      }
      {
        key = "<leader>ss";
        action = "<cmd>Telescope aerial<cr>";
        options = {desc = "code symbol search";};
      }
      {
        key = "<leader>so";
        action = "<cmd>AerialToggle<cr>";
        options = {desc = "code symbol outline";};
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      aerial-nvim
    ];

    extraConfigLua = ''
      require("aerial").setup({})
    '';
  };
}
