{...}: {
  programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          which_key = true;
        };
      };
    };

    # key bind hints
    plugins.which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>a";
            group = "ai";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "code";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "find";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "git";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "lsp";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "test";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "symbols";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "ui";
          }
        ];
      };
    };
  };
}
