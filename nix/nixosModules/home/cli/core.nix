{
  pkgs,
  lib,
  ...
}: {
  home = {
    sessionVariables = {
      # nvim as the default editor
      EDITOR = "nvim";
      # nvim as the default editor
      VISUAL = "nvim";
    };
  };

  programs = {
    # cat replacement
    bat = {
      enable = true;
    };

    # top replacement
    btop = {
      enable = true;
      settings = {
        # show cpu usage of the core rather than total
        proc_per_core = true;
        # show processes in a tree
        proc_tree = true;
      };
    };

    # environment loading
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # find replacement
    fd = {
      enable = true;
      # show hidden files by default
      hidden = true;
      # exclude git from hidden files
      ignores = [
        ".git/"
      ];
    };

    # fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getExe pkgs.fd} --type f";
      defaultOptions = ["--reverse" "--height 40%"];
    };

    # json manipulation
    jq.enable = true;

    # grep replacement
    ripgrep = {
      enable = true;
      # exclude git from hidden files
      arguments = [
        "--glob=!.git/*"
      ];
    };

    # shell prompt
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # file manager
    yazi = {
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

      # auto complete ghost text
      autosuggestion.enable = true;

      shellAliases = {
        b = "${lib.getExe pkgs.bat}";
        f = "${lib.getExe pkgs.fzf}";
        g = "${lib.getExe pkgs.git}";
        l = "${lib.getExe pkgs.eza} -la --icons --no-permissions --no-user";
        la = "${lib.getExe pkgs.eza} -la";
        ll = "${lib.getExe pkgs.eza} -la --icons";
        lt = "${lib.getExe pkgs.eza} -l --tree";
        md = "${lib.getExe' pkgs.coreutils "mkdir"} -p";
        y = "${lib.getExe pkgs.yazi}";
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
