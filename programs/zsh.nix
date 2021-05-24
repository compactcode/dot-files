{ ... }: {
  programs = {
    zsh = {
      enable = true;

      prezto = {
        enable = true;

        pmodules = [
          "archive"
          "directory"
          "completion"
          "editor"
          "environment"
          "history"
        ];
      };

      shellAliases = {
        md = "mkdir -p";
      };
    };
  };
}
