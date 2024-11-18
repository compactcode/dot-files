{...}: {
  programs.nixvim = {
    # auto complete
    plugins.cmp = {
      enable = true;
      settings = {
        formatting.format.__raw = ''
          function(entry, vim_item)
            -- replace kind with mini lsp icon
            local icon, _ = require("mini.icons").get("lsp", vim_item.kind)
            if icon ~= nil then
              vim_item.kind = icon
            end
            return vim_item
          end
        '';
        mapping.__raw = ''
          cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-e>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          })
        '';
        snippet = {
          expand = "luasnip";
        };
        sources = [
          # snippets
          {name = "luasnip";}
          # lsp servers
          {name = "nvim_lsp";}
          # local filesystem paths
          {name = "path";}
          # content from open buffers
          {
            name = "buffer";
            # use all buffers not just the current one
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
        ];
      };
    };
  };
}
