{ lib, pkgs, ... }:

let
  settings = import ../../settings.nix;

in {
  imports = [
    ./basic/fre.nix
    ./basic/neovim.nix
  ];

  home.packages = with pkgs; [
    exa # ls replacement.
    fd # find replacement.
    fre # frequency/recency tracker.
    ripgrep # grep replacement.
  ];

  programs = {
    # cat replacement.
    bat = {
      enable = true;
      config = {
        theme = "nord";
      };
      themes = {
        nord = (builtins.readFile ../themes/base_16_nord.tmTheme);
      };
    };

    # environment autoloading.
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    # version control.
    git = {
      enable = true;
      userName = settings.user.name;
      userEmail = settings.user.email;
      signing = {
        signByDefault = true;
        key = settings.user.gpg.signingKey;
      };
      delta = {
        enable = true;
      };
    };

    # process viewing.
    htop = {
      enable = true;
      fields = [
         "PID" "USER" "M_SIZE" "M_RESIDENT" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM"
      ];
      showProgramPath = false;
    };

    # file managing.
    lf = {
      enable = true;
    };

    # fuzzy finding.
    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [
        "--reverse"
        "--height 40%"
      ];
    };

    # bash prompt.
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # bash replacement.
    zsh = {
      enable = true;

      prezto = {
        enable = true;

        pmodules = [
          "archive"
          "environment"
          "editor"
          "directory"
          "history"
        ];
      };

      sessionVariables = {
        EDITOR = "vim";
      };

      shellAliases = {
        b    = "${pkgs.bat}/bin/bat";
        g    = "${pkgs.git}/bin/git";
        ga   = "${pkgs.git}/bin/git add";
        gars = "${pkgs.git}/bin/git add . && git reset --hard";
        gc   = "${pkgs.git}/bin/git commit";
        gca  = "${pkgs.git}/bin/git commit --amend";
        gcm  = "${pkgs.git}/bin/git commit -m";
        gco  = "${pkgs.git}/bin/git checkout";
        gcp  = "${pkgs.git}/bin/git cherry-pick";
        gd   = "${pkgs.git}/bin/git diff";
        gdc  = "${pkgs.git}/bin/git diff --cached";
        glg  = "${pkgs.git}/bin/git log --stat";
        glr  = "${pkgs.git}/bin/git pull --rebase";
        grh  = "${pkgs.git}/bin/git reset HEAD";
        grm  = "${pkgs.git}/bin/git rm";
        gs   = "${pkgs.git}/bin/git status";
        l    = "${pkgs.exa}/bin/exa -la";
        lt   = "${pkgs.exa}/bin/exa -l --tree";
        md   = "mkdir -p";
        o    = "xdg-open";
        v    = "vim";
      };
    };
  };
}
