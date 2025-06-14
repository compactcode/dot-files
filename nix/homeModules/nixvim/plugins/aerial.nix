{...}: {
  programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          aerial = true;
        };
      };
    };

    plugins.aerial = {
      enable = true;

      # delay loading until requested
      lazyLoad.settings = {
        cmd = ["AerialInfo" "AerialOpen" "AerialToggle"];
        keys = [
          {
            __unkeyed-1 = "<leader>ss";
            __unkeyed-2 = "<cmd>Telescope aerial<cr>";
            desc = "code symbol search";
          }
          {
            __unkeyed-1 = "<leader>so";
            __unkeyed-2 = "<cmd>AerialToggle<cr>";
            desc = "code symbol outline";
          }
        ];
      };
    };
  };
}
