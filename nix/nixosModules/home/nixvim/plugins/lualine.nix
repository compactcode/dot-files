{...}: {
  programs.nixvim = {
    plugins.lualine = {
      enable = true;

      componentSeparators = {
        left = "";
        right = "";
      };

      # one status line for all windows
      globalstatus = true;

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
          "diagnostics"
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
  };
}
