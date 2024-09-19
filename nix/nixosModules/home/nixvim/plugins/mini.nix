{...}: {
  programs.nixvim = {
    # collection of plugins
    plugins.mini = {
      enable = true;
      modules = {
        # text objects
        ai = {
          n_lines = 500;
          custom_textobjects = {
            # manipulate a class
            c.__raw = ''
              require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
            '';
            # manipulate a function
            f.__raw = ''
              require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
            '';
            # manipulate a code block
            o.__raw = ''
              require("mini.ai").gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
              })
            '';
          };
        };
        align = {}; # text alignment
        indentscope = {}; # indent decorations
        pairs = {}; # auto pairs
        surround = {}; # surround actions
      };
    };
  };
}
