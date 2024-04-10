{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    colorschemes.nord = {
      enable = true;
      settings = {
        contrast = true;
        borders = true;
      };
    };

    globals.mapleader = " ";

    keymaps = [
      {
        key = "m";
        action = "h";
      } # colemak hjkl
      {
        key = "n";
        action = "j";
      } # colemak hjkl
      {
        key = "e";
        action = "k";
      } # colemak hjkl
      {
        key = "i";
        action = "l";
      } # colemak hjkl
      {
        key = "h";
        action = "n";
      } # colemak n
      {
        key = "Q";
        action = "<cmd>wa<cr>ZZ";
      } # save all and exit
      {
        key = "S";
        action = "function() require(\"flash\").treesitter() end";
        lua = true;
      } # select using treesitter
      {
        key = "<leader>t";
        action = "<cmd>Telescope find_files<cr>";
      } # open any file
      {
        key = "<leader>ff";
        action = "<cmd>Telescope frecency<cr>";
      } # open recent file
      {
        key = "<leader>fs";
        action = "<cmd>Telescope live_grep<cr>";
      } # search files
    ];

    opts = {
      expandtab = true; # convert tabs to spaces
      tabstop = 2; # use 2 spaces for tab
      softtabstop = 2; # use 2 spaces for tab
      shiftwidth = 2; # use 2 spaces for tab
      number = true; # show line numbers
      backup = false; # disable file versioning
      swapfile = false; # disable file versioning
      writebackup = false; # disable file versioning
    };

    plugins = {
      conform-nvim = {
        enable = true;
        formatOnSave = {
          lspFallback = true;
        };
        formatters = {
          alejandra = {
            command = "${pkgs.alejandra}/bin/alejandra";
          };
        };
        formattersByFt = {
          nix = ["alejandra"];
        };
      };

      cmp = {
        enable = true;
        settings = {
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
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
        };
      };

      flash = {
        enable = true;
      };

      friendly-snippets = {
        enable = true;
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
        };
      };

      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
          };
        };
      };

      lspkind = {
        enable = true;
        cmp.enable = true;
        mode = "symbol";
      };

      lualine = {
        enable = true;
        componentSeparators = {
          left = "";
          right = "";
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = [
            {
              name = "filename";
              extraConfig.path = 1;
            }
          ];
          lualine_x = [
            "encoding"
            "fileformat"
            {
              name = "filetype";
              extraConfig.colored = false;
            }
          ];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
      };

      luasnip = {
        enable = true;
      };

      mini = {
        enable = true;
        modules = {
          comment = {}; # comment toggle
          pairs = {}; # auto close common pairs
        };
      };

      treesitter = {
        enable = true;
        indent = true;
      };

      telescope = {
        enable = true;
        extensions = {
          frecency = {
            enable = true;
          };
          fzf-native = {
            enable = true;
          };
        };
        settings = {
          defaults = {
            mappings = {
              i = {
                "<C-n>" = "move_selection_next";
                "<C-e>" = "move_selection_previous";
              };
            };
            sorting_strategy = "ascending";
          };
        };
      };
    };
  };
}
