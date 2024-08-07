{...}: {
  programs.nixvim = {
    # collection of plugins
    plugins.mini = {
      enable = true;
      modules = {
        ai = {}; # text objects
        align = {}; # text alignment
        indentscope = {}; # indent decorations
        pairs = {}; # auto pairs
        surround = {}; # surround actions
      };
    };
  };
}
