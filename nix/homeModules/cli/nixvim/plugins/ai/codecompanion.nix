{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>aa";
        action = "<cmd>CodeCompanionChat Add<cr>";
        mode = ["v"];
        options = {desc = "add selection to context";};
      }
      {
        key = "<leader>ar";
        action = "<cmd>CodeCompanionActions<cr>";
        mode = ["n"];
        options = {desc = "actions";};
      }
      {
        key = "<leader>at";
        action = "<cmd>CodeCompanionChat toggle<cr>";
        mode = ["n"];
        options = {desc = "chat";};
      }
    ];

    # ai assistant
    plugins.codecompanion = {
      enable = true;

      settings = {
        adapters = {
          gemini = {
            # use 1password to retrieve api key
            __raw = ''
              function()
                return require('codecompanion.adapters').extend('gemini', {
                  env = {
                    api_key = "cmd:op read op://personal/google/aistudio-api-key --no-newline"
                  },
                })
              end
            '';
          };
        };

        strategies = {
          agent = {
            adapter = "gemini";
          };
          chat = {
            adapter = "gemini";
          };
          inline = {
            adapter = "gemini";
          };
        };
      };

      # delay loading until requested
      lazyLoad.settings = {
        cmd = [
          "CodeCompanion"
          "CodeCompanionActions"
          "CodeCompanionChat"
          "CodeCompanionCmd"
        ];
      };
    };
  };
}
