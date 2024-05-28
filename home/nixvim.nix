{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    keymaps = [
      {
        key = "Q";
        action = "<cmd>wa<cr>ZZ";
        options = {desc = "save all and exit";};
      }
      {
        key = "S";
        action.__raw = "function() require(\"flash\").treesitter() end";
        options = {desc = "select using treesitter";};
      }
      {
        key = "<leader>d";
        action = "<cmd>Telescope lsp_definitions<cr>";
        options = {desc = "goto definition";};
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope frecency<cr>";
        options = {desc = "find commonly edited files";};
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope git_files<cr>";
        options = {desc = "find files (hidden)";};
      }
      {
        key = "<leader>fo";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {desc = "find last edited files";};
      }
      {
        key = "<leader>fs";
        action = "<cmd>Telescope live_grep<cr>";
        options = {desc = "search project";};
      }
      {
        key = "<leader>fw";
        action = "<cmd>Telescope grep_string<cr>";
        options = {desc = "search project for current word";};
      }
      {
        key = "<leader>la";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options = {desc = "code actions";};
      }
      {
        key = "<leader>o";
        action = "<cmd>Oil<cr>";
        options = {desc = "explore files";};
      }
      {
        key = "<leader>t";
        action = "<cmd>Telescope find_files<cr>";
        options = {desc = "find files";};
      }
    ];

    opts = {
      backup = false; # disable file versioning
      expandtab = true; # convert tabs to spaces
      ignorecase = true; # ignore case by default
      number = true; # show line numbers
      shiftwidth = 2; # use 2 spaces for tab
      smartcase = true; # don't ignore case if a capital is typed
      softtabstop = 2; # use 2 spaces for tab
      swapfile = false; # disable file versioning
      tabstop = 2; # use 2 spaces for tab
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
          comment = {}; # comment lines
          pairs = {}; # auto pairs
          surround = {}; # surround actions
        };
      };

      # file explorer
      oil.enable = true;

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

      # key binding menu
      which-key.enable = true;
    };
  };
}
