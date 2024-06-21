{
  pkgs,
  lib,
  ...
}: {
  home = {
    sessionVariables = {
      # nvim as the default editor
      EDITOR = "nvim";
    };
  };

  programs = {
    # fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = ["--reverse" "--height 40%"];
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
        l = "${pkgs.eza}/bin/eza -la --icons --no-permissions --no-user";
        la = "${pkgs.eza}/bin/eza -la";
        ll = "${pkgs.eza}/bin/eza -la --icons";
        lt = "${pkgs.eza}/bin/eza -l --tree";
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
