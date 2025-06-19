{...}: {
  programs.nixvim = {
    plugins.codecompanion = {
      enable = true;

      settings = {
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
