{pkgs, ...}: {
  programs.nixvim = {
    # keymaps = [
    #   {
    #     key = "<leader>o";
    #     action = "<cmd>Other<cr>";
    #     options = {desc = "open alternate file";};
    #   }
    # ];

    # ai assistant
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "aider";
        src = pkgs.fetchFromGitHub {
          owner = "GeorgesAlkhouri";
          repo = "nvim-aider";
          rev = "e15ea121074e774e436eb2223929fde7a01d4f52";
          hash = "<nix NAR hash>";
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
