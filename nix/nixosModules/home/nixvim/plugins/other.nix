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
      (pkgs.vimUtils.buildVimPlugin {
        name = "other";
        src = pkgs.fetchFromGitHub {
          owner = "rgroli";
          repo = "other.nvim";
          rev = "252cc279eb3d76685ef48aaeced1c3cf9793581f";
          hash = "sha256-ezhaQO71Jr2q58qb1lUlX2xsiOhgP52N5/jD9oRckck=";
        };
      })
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
