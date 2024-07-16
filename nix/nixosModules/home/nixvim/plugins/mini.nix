{...}: {
  programs.nixvim = {
    # collection of plugins
    plugins.mini = {
      enable = true;
      modules = {
        ai = {}; # text objects
        indentscope = {}; # indent decorations
        pairs = {}; # auto pairs
        surround = {}; # surround actions
      };
    };
  };
}
