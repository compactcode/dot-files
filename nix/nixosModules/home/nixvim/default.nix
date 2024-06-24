{...}: {
  imports = [
    ./plugins/aerial.nix
    ./plugins/conform.nix
    ./plugins/lualine.nix
    ./plugins/neotest.nix
  ];

  programs.nixvim = {
    enable = true;

    # disable unused providers
    withRuby = false;
    withNodeJs = false;

    globals.mapleader = " ";

    keymaps = [
      {
        key = "<c-left>";
        action = "<C-w>h";
      }
      {
        key = "<c-down>";
        action = "<C-w>j";
      }
      {
        key = "<c-up>";
        action = "<C-w>k";
      }
      {
        key = "<c-right>";
        action = "<C-w>l";
      }
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
        key = "<leader>as";
        action = "<cmd>lua require(\"spectre\").open()<cr>";
        options = {desc = "search and replace";};
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope frecency<cr>";
        options = {desc = "find commonly edited files";};
      }
      {
        key = "<leader>fm";
        action = "<cmd>Telescope marks<cr>";
        options = {desc = "find marks";};
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
        key = "<leader>go";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"n\", {action_callback = require(\"gitlinker.actions\").open_in_browser})<cr>";
        mode = ["n"];
        options = {desc = "open permalink url to current line";};
      }
      {
        key = "<leader>go";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"v\", {action_callback = require(\"gitlinker.actions\").open_in_browser})<cr>";
        mode = ["v"];
        options = {desc = "open permalink url to current lines";};
      }
      {
        key = "<leader>gy";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"n\")<cr>";
        mode = ["n"];
        options = {desc = "copy permalink url to current line";};
      }
      {
        key = "<leader>gy";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"v\")<cr>";
        mode = ["v"];
        options = {desc = "copy permalink url to current lines";};
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
        key = "<leader>W";
        action = "<cmd>wa<cr>";
        options = {desc = "save all files";};
      }
      {
        key = "<leader>y";
        action = "\"+y";
        options = {desc = "copy to system clipboard";};
      }
      {
        key = "<leader>q";
        action = "<cmd>qa!<cr>";
        options = {desc = "exit immediately";};
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
      # auto complete
      cmp = {
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
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
        };
      };

      # linting
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

      # enhanced versions of builtin motions
      flash = {
        enable = true;
        # add jump labels to the default search
        modes.search.enabled = true;
      };

      # default library of snippets
      friendly-snippets.enable = true;

      # git permalinks
      gitlinker.enable = true;

      # git decorations
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
          # general purpose (linting/formatting efc)
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

      luasnip = {
        enable = true;
      };

      mini = {
        enable = true;
        modules = {
          indentscope = {}; # indent decorations
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
