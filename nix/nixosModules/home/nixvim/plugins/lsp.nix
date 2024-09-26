{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>la";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options = {desc = "code actions";};
      }
      {
        key = "<leader>lh";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options = {desc = "show info about symbol";};
      }
    ];

    plugins = {
      # general purpose linting
      efmls-configs = {
        enable = true;
        setup = {
          json = {
            linter = "jq";
          };
          yaml = {
            linter = "yamllint";
          };
        };
      };

      # lsp status notifications
      fidget.enable = true;

      # lsp servers
      lsp = {
        enable = true;

        # configured but not installed (projects provide their own)
        enabledServers = [
          # ruby
          {
            name = "ruby_lsp";
            extraOptions = {};
          }
        ];

        # configured and installed
        servers = {
          # bash
          bashls.enable = true;
          # general purpose
          efm = {
            enable = true;
            extraOptions = {
              init_options = {
                # conform handles formatting
                documentFormatting = false;
                documentRangeFormatting = false;
              };
            };
          };
          # html
          emmet-ls.enable = true;
          # nix
          nixd.enable = true;
          # html
          tailwindcss.enable = true;
        };
      };
    };
  };
}
