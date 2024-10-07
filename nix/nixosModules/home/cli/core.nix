{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = [
      # zip/archive handling
      pkgs.ouch
    ];

    sessionVariables = {
      # nvim as the default editor
      EDITOR = "nvim";
      # nvim as the default editor
      VISUAL = "nvim";
    };
  };

  programs = {
    # shell history database
    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        # search bar at the top
        invert = true;
        # display results inline instead of fullscreen.
        inline_height = 25;
        # simplify the ui
        style = "compact";
      };
    };

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
      # use fd for listing files
      defaultCommand = "${lib.getExe pkgs.fd} --type f";
      defaultOptions = [
        # search bar at the top
        "--reverse"
        # display results inline instead of fullscreen
        "--height 40%"
      ];
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
        c = "clear";
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

  # automatic styling
  stylix = {
    targets = {
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      yazi.enable = true;
    };
  };
}
