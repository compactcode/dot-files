{ pkgs, lib, ... }:

{
  home = {
    sessionVariables = {
      # nvim as the default editor
      EDITOR = "nvim";
    };
    stateVersion = "22.11";
  };

  programs = {
    # fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [ "--reverse" "--height 40%" ];
    };

    # shell prompt
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # smart cd with jumping
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # shell
    zsh = {
      enable = true;

      shellAliases = {
        b = "${pkgs.bat}/bin/bat";
        j = "z";
        l = "${pkgs.exa}/bin/exa -la --icons --no-permissions --no-user";
        la = "${pkgs.exa}/bin/exa -la";
        ll = "${pkgs.exa}/bin/exa -la --icons";
        lt = "${pkgs.exa}/bin/exa -l --tree";
        md = "mkdir -p";
        v = "nvim";
      };

      prezto = {
        enable = true;

        pmodules = [
          "completion" # auto completion
          "directory" # auto pushd/popd
          "editor" # emacs key bindings
          "history" # history setup
        ];
      };
    };
  };
}
