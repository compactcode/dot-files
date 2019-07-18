{ pkgs, ... }:

{
  # Temporary workaround for an issue in the 19.03 branch.
  home.sessionVariables = {
    SKIM_DEFAULT_OPTIONS = "--reverse --height 40%";
  };

  programs.skim = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    # Doesn't work in the 19.03 branch.
    # defaultOptions = [
    #   "--reverse"
    #   "--height 40%"
    # ];
  };
}
