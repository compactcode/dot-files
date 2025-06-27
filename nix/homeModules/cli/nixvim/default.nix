{...}: {
  imports = [
    # ./plugins/spectre.nix
    ./plugins/aerial.nix
    ./plugins/ai/avante.nix
    ./plugins/ai/codecompanion.nix
    ./plugins/blink.nix
    ./plugins/conform.nix
    ./plugins/flash.nix
    ./plugins/gitlinker.nix
    ./plugins/gitsigns.nix
    ./plugins/grug-far.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/mini.nix
    ./plugins/neotest.nix
    ./plugins/oil.nix
    ./plugins/other.nix
    ./plugins/render-markdown.nix
    ./plugins/snacks.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/which-key.nix
  ];

  programs.nixvim = {
    enable = true;

    # recognise slim-rails files
    # https://github.com/slim-template/slim-rails/blob/a6ae6b27d625b3703d9447cb5737b7007ce7874e/lib/slim-rails/register_engine.rb#L34
    autoCmd = [
      {
        event = ["BufReadPost" "BufNewFile"];
        pattern = "*.slim";
        command = "set filetype=slim";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

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
        key = "<leader>uc";
        action = "<cmd>nohlsearch<cr>";
        options = {desc = "clear search highlight";};
      }
      {
        key = "<leader>fc";
        action = "<cmd>let @+ = expand('%')<cr>";
        options = {desc = "copy the current path to clipboard";};
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
      # lazy loading
      lz-n.enable = true;

      # clipboard manager
      yanky = {
        enable = true;
        # enable telescope ingegration
        enableTelescope = true;
      };
    };

    # disable unused providers
    withNodeJs = false;
    withPerl = false;
    withRuby = false;
  };
}
