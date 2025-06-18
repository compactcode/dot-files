{...}: {
  programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          avante = true;
        };
      };
    };

    plugins.avante = {
      enable = true;

      settings = {
        # use snacks.nvim for input
        input = {
          provider = "snacks";
          provider_opts = {
            title = "Avante Input";
            icon = " ";
          };
        };

        gemini = {
          model = "gemini-2.5-flash-preview-05-20";
        };

        provider = "gemini";
      };

      # delay loading until requested
      lazyLoad.settings = {
        cmd = [
          "AvanteAsk"
          "AvanteBuild"
          "AvanteChat"
          "AvanteEdit"
          "AvanteFocus"
          "AvanteRefresh"
          "AvanteSwitchProvider"
          "AvanteShowRepoMap"
          "AvanteToggle"
        ];
      };
    };
  };
}
