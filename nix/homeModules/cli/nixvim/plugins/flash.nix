{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "S";
        action = "<cmd>lua require(\"flash\").treesitter()<cr>";
        options = {desc = "select using treesitter";};
      }
    ];

    # enhanced versions of builtin motions
    plugins.flash = {
      enable = true;

      # add jump labels to the default search
      settings.modes.search.enabled = true;

      # delay loading until the ui is loaded
      lazyLoad.settings = {
        event = "DeferredUIEnter";
      };
    };
  };
}
