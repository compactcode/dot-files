{...}: {
  programs.nixvim = {
    # auto complete
    plugins = {
      blink-cmp = {
        enable = true;

        # https://github.com/nix-community/nixvim/issues/3001
        # Not needed on latest versions of neovim.
        setupLspCapabilities = false;

        settings = {
          completion = {
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
          # use neovim built in snippet functionality
          snippets.preset = "default";
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
