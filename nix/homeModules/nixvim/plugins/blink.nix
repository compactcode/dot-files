{...}: {
  programs.nixvim = {
    # auto complete
    plugins = {
      blink-cmp = {
        enable = true;
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
