{ config, lib, pkgs, ... }:

let
  settings = import ../../settings.nix;

in {
  home = {
    packages = with pkgs; [
      aws-vault # secure aws credential handling.
      chafa # image viewer.
      du-dust # du replacement.
      exa # ls replacement.
      fd # find replacement.
      file # file type detector.
      poppler_utils # pdf viewer.
      ripgrep # grep replacement.
      tig # git viewer.
      unzip # opening zip archives.
      w3m # html viewer.
      xsv # csv viewer.
    ];

    sessionVariables = {
      AWS_VAULT_BACKEND = "pass";
      AWS_VAULT_PROMPT = "pass";
      BROWSER = "firefox";
      EDITOR = "vim";
      LF_ICONS="di=:fi=:ex=:ln=:*.png=:*.jpg=:*.jpeg=:*.pdf=:*.csv=:*.rb=:*.js=:*.json=ﬥ:*.nix=:*.yml=:";
    };
  };

  programs = {
    # cat replacement.
    bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
    };

    # environment autoloading.
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };

    # fuzzy finding.
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [
        "--reverse"
        "--height 40%"
      ];
    };

    # version control.
    git = {
      enable = true;
      delta = {
        enable = true;
      };
      ignores = [
        ".direnv"
        ".envrc"
        "shell.nix"
      ];
      signing = {
        signByDefault = true;
        key = settings.user.gpg.signingKey;
      };
      userName = settings.user.name;
      userEmail = settings.user.email;
    };

    # process viewing.
    htop = {
      enable = true;
      settings = {
        fields = with config.lib.htop.fields; [
          PID
          USER
          M_SIZE
          M_RESIDENT
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];
        show_program_path = false;
      };
    };

    # file managing.
    lf = {
      enable = true;

      previewer = {
        source = pkgs.writeShellScript "preview.sh" ''
          #!/usr/bin/env bash

          FILE_PATH="$1"
          HEIGHT="$2"

          case "$1" in
              *.csv) xsv sample 25 "$FILE_PATH" | xsv table;;
              *.jpeg) chafa --fill=block --symbols=block -c 256 -s 80x"$HEIGHT" "$FILE_PATH";;
              *.jpg) chafa --fill=block --symbols=block -c 256 -s 80x"$HEIGHT" "$FILE_PATH";;
              *.pdf) pdftotext -l 5 -nopgbrk -q -- "$FILE_PATH" -;;
              *.png) chafa --fill=block --symbols=block -c 256 -s 80x"$HEIGHT" "$FILE_PATH";;
              *) bat --color=always "$FILE_PATH";;
          esac
        '';
      };

      settings = {
        icons = true;
        incsearch = true;
      };
    };

    # gpg password manager.
    password-store = {
      enable = true;

      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
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
          "directory"
          "completion"
          "editor"
          "environment"
          "history"
        ];
      };

      shellAliases = {
        b    = "${pkgs.bat}/bin/bat";
        be   = "bundle exec";
        ber  = "bundle exec rspec";
        berc = "bundle exec rails console";
        bers = "bundle exec rails server";
        bi   = "bundle install";
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
        l    = "${pkgs.exa}/bin/exa -la --icons --no-permissions --no-user";
        la   = "${pkgs.exa}/bin/exa -la";
        ll   = "${pkgs.exa}/bin/exa -la --icons";
        lt   = "${pkgs.exa}/bin/exa -l --tree";
        md   = "mkdir -p";
        o    = "xdg-open";
        v    = "vim";
      };
    };
  };
}
