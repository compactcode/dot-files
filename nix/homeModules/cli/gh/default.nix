{
  # github cli
  programs = {
    gh = {
      enable = true;
    };
    zsh = {
      shellAliases = {
        # open current pr in a browser
        ghp = "gh pr view --web";
        # view checks for current pr
        ghc = "gh pr checks";
      };
    };
  };
}
