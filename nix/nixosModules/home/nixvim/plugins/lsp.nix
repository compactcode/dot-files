{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>la";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options = {desc = "code actions";};
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
          # bash
          bashls.enable = true;
          # nix
          nixd.enable = true;
        };
      };

      # autocomplete source icons
      lspkind = {
        enable = true;
        cmp.enable = true;
        mode = "symbol";
      };
    };
  };
}
