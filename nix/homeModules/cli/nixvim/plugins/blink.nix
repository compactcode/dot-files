{config, ...}: {
  programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          blink_cmp = true;
        };
      };
    };

    # auto complete
    plugins = {
      blink-cmp = {
        enable = true;

        # https://github.com/nix-community/nixvim/issues/3001
        # Not needed on latest versions of neovim.
        setupLspCapabilities = false;

        settings = {
          completion = {
            # always show documentation preview, useful for snippets
            documentation.auto_show = true;

            menu = {
              draw = {
                components = {
                  # use mini.icons
                  kind_icon = {
                    text.__raw = ''
                      function(ctx)
                        local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                        return kind_icon
                      end,
                      highlight = function(ctx)
                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                        return hl
                      end
                    '';
                  };
                };
              };
            };
          };

          # enable when typing commands
          cmdline.completion.menu.auto_show.__raw = ''
            function(ctx)
              return vim.fn.getcmdtype() == ':'
            end
          '';

          # use neovim built in snippet functionality
          snippets.preset = "default";

          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];

            providers = {
              # keep the buffer source enabled when an lsp is attached
              lsp.fallbacks = config.lib.nixvim.utils.emptyTable;
            };
          };
        };

        # delay loading until inserting text
        lazyLoad.settings = {
          event = ["InsertEnter" "CmdlineEnter"];
        };
      };

      # default snippets
      friendly-snippets.enable = true;
    };
  };

  # custom snippets
  xdg.configFile."nvim/snippets/" = {
    source = ../snippets;
    recursive = true;
  };
}
