{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>tt";
        action = "<cmd>lua Snacks.terminal.toggle()<cr>";
        mode = ["n"];
        options = {desc = "open terminal";};
      }
      {
        key = "<C-/>";
        action = "<cmd>close<cr>";
        mode = ["t"];
        options = {desc = "hide terminal";};
      }
    ];

    # collection of plugins
    plugins.snacks = {
      enable = true;

      settings = {
        # upgrade input prompt
        input = {
          enable = true;
        };

        # terminal utilities
        terminal = {
          enable = true;
        };
      };

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
