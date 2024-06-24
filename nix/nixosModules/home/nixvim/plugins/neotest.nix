{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "gt";
        action = "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>";
        options = {desc = "jump to next failed test";};
      }
      {
        key = "<leader>ra";
        action = "<cmd>lua require('neotest').run.run(vim.fn.expand(\"%\"))<cr>";
        options = {desc = "run file";};
      }
      {
        key = "<leader>rn";
        action = "<cmd>lua require('neotest').run.run()<cr>";
        options = {desc = "run nearest";};
      }
      {
        key = "<leader>ro";
        action = "<cmd>lua require('neotest').output.open()<cr>";
        options = {desc = "test output";};
      }
      {
        key = "<leader>rr";
        action = "<cmd>lua require('neotest').run.run_last()<cr>";
        options = {desc = "run last test";};
      }
    ];

    # test runner
    plugins.neotest = {
      enable = true;

      adapters = {
        # ruby rspec
        rspec.enable = true;
      };

      settings = {
        # disable quickfix integration
        quickfix.enable = true;
        # disable scanning for test files
        discovery.enable = true;
      };
    };
  };
}
