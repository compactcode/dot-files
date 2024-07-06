{...}: {
  programs.nixvim = {
    # auto complete
    plugins.cmp = {
      enable = true;
      settings = {
        # show current completion inline
        experimental = {
          ghost_text = true;
        };
        snippet = {
          expand = "luasnip";
        };
        mapping.__raw = ''
          cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-e>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          })
        '';
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
