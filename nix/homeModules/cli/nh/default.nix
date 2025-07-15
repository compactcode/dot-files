{
  programs = {
    # nix helper
    nh = {
      enable = true;
      # automatic garbage collection
      clean = {
        enable = true;
        extraArgs = "--keep 25 --keep-since 30d";
      };
      # TODO: find a less hacky way to set this
      flake = "/home/shandogs/Projects/personal/dot-files";
    };
  };
}
