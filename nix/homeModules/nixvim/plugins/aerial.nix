{pkgs, ...}: {
  programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          aerial = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>ss";
        action = "<cmd>Telescope aerial<cr>";
        options = {desc = "code symbol search";};
      }
      {
        key = "<leader>so";
        action = "<cmd>AerialToggle<cr>";
        options = {desc = "code symbol outline";};
      }
    ];

    plugins.aerial = {
      enable = true;
    };
  };
}
