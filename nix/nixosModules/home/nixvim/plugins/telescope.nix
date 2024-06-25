{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>d";
        action = "<cmd>Telescope lsp_definitions<cr>";
        options = {desc = "goto definition";};
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope frecency workspace=CWD<cr>";
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
        key = "<leader>p";
        action = "<cmd>Telescope yank_history<cr>";
        options = {desc = "paste from history";};
      }
      {
        key = "<leader>t";
        action = "<cmd>Telescope find_files<cr>";
        options = {desc = "find files";};
      }
    ];

    plugins.telescope = {
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
          oldfiles = {
            # only show files in cwd
            only_cwd = true;
          };
        };
      };
    };
  };
}
