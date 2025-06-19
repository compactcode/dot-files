{...}: {
  programs.nixvim = {
    plugins.codecompanion = {
      enable = true;

      settings = {
        adapters = {
          gemini = {
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
