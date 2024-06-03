{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;

    # disable unused providers
    withRuby = false;
    withNodeJs = false;

    globals.mapleader = " ";

    keymaps = [
      {
        key = "<c-n>";
        action = "<Plug>(YankyPreviousEntry)";
        mode = ["n"];
        options = {desc = "cycle to previous yanky entry";};
      }
      {
        key = "<c-e>";
        action = "<Plug>(YankyNextEntry)";
        mode = ["n"];
        options = {desc = "cycle to next yanky entry";};
      }
      {
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        mode = ["n" "x"];
        options = {desc = "paste using yanky";};
      }
      {
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        mode = ["n" "x"];
        options = {desc = "paste using yanky";};
      }
      {
        key = "S";
        action = "<cmd>lua require(\"flash\").treesitter()<cr>";
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
        key = "<leader>fo";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {desc = "find last edited files";};
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope resume<cr>";
        options = {desc = "resume last search";};
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
        key = "<leader>p";
        action = "<cmd>Telescope yank_history<cr>";
        options = {desc = "paste from history";};
      }
      {
        key = "<leader>s";
        action = "<cmd>lua require(\"spectre\").open()<cr>";
        options = {desc = "search and replace";};
      }
      {
        key = "<leader>t";
        action = "<cmd>Telescope find_files<cr>";
        options = {desc = "find files";};
      }
      {
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options = {desc = "save file";};
      }
      {
        key = "<leader>y";
        action = "\"+y";
        options = {desc = "copy to system clipboard";};
      }
      {
        key = "<leader>q";
        action = "<cmd>wa<cr>ZZ";
        options = {desc = "save all and exit";};
      }
    ];

    opts = {
      backup = false; # disable file versioning
      expandtab = true; # convert tabs to spaces
      ignorecase = true; # ignore case by default
      foldenable = false; # disable code folding
      list = true; # enable listchars
      listchars = {
        nbsp = "+"; # display non breaking spaces
        tab = ">~"; # display tabs
        trail = "·"; # display any trailing spaces
      };
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
            command = "${lib.getExe pkgs.alejandra}";
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
        # add jump labels to the default search
        modes.search.enabled = true;
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
        enabledServers = [
          {
            # ruby, installed per project
            name = "ruby_lsp";
            extraOptions = {};
          }
        ];
        servers = {
          # bash
          bashls.enable = true;
          # nix
          nixd.enable = true;
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

      # search and replace
      spectre.enable = true;

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
            # the colors are distracting and not very useful
            color_devicons = false;
            mappings = {
              i = {
                "<C-n>" = "move_selection_next";
                "<C-e>" = "move_selection_previous";
              };
            };
            sorting_strategy = "ascending";
            # include hidden files by default
            vimgrep_arguments = [
              "rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
              "--hidden"
            ];
          };
          pickers = {
            find_files = {
              # include hidden files by default
              find_command = ["fd" "--type" "f" "--hidden"];
            };
          };
        };
      };

      # clipboard manager
      yanky = {
        enable = true;
        # enable telescope ingegration
        picker = {
          telescope.enable = true;
        };
      };

      # key binding menu
      which-key.enable = true;
    };
  };
}
