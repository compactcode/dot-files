{...}: {
  imports = [
    ./plugins/aerial.nix
    ./plugins/cmp.nix
    ./plugins/conform.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/luasnip.nix
    ./plugins/neotest.nix
    ./plugins/oil.nix
    ./plugins/telescope.nix
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
        key = "<leader>as";
        action = "<cmd>lua require(\"spectre\").open()<cr>";
        options = {desc = "search and replace";};
      }
      {
        key = "<leader>c";
        action = "<cmd>nohlsearch<cr>";
        options = {desc = "clear search highlight";};
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
      # enhanced versions of builtin motions
      flash = {
        enable = true;
        # add jump labels to the default search
        settings.modes.search.enabled = true;
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

      mini = {
        enable = true;
        modules = {
          indentscope = {}; # indent decorations
          pairs = {}; # auto pairs
          surround = {}; # surround actions
        };
      };

      # search and replace
      spectre.enable = true;

      treesitter = {
        enable = true;
        indent = true;
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
