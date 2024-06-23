{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./zellij
  ];

  # code formatter preferences
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        trim_trailing_whitespace = true;
        indent_style = "space";
        indent_size = 2;
      };
    };
  };

  home = {
    sessionVariables = {
      # nvim as the default editor
      EDITOR = "nvim";
      # nvim as the default editor
      VISUAL = "nvim";
    };
  };

  programs = {
    # github cli
    gh.enable = true;

    # version control
    git = {
      enable = true;
      extraConfig = {
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
      };
      # use delta for nice diff output
      delta.enable = true;
      ignores = [
        ".devenv"
        ".direnv"
        "node_modules"
      ];
      userName = "Shanon McQuay";
      userEmail = "hi@shan.dog";
    };

    # git ui
    lazygit = {
      enable = true;
      settings = {
        git = {
          # annoying as it prompts for authentication
          autoFetch = false;
        };
      };
    };

    # shell
    zsh = {
      shellAliases = {
        be = "bundle exec";
        ber = "bundle exec rspec";
        berc = "bundle exec rails console";
        bers = "bundle exec rails server";
        bi = "bundle install";
        bu = "bundle update";
        ga = "${lib.getExe pkgs.git} add";
        gars = "${lib.getExe pkgs.git} add . && git reset --hard";
        gc = "${lib.getExe pkgs.git} commit";
        gca = "${lib.getExe pkgs.git} commit --amend";
        gcm = "${lib.getExe pkgs.git} commit -m";
        gco = "${lib.getExe pkgs.git} checkout";
        gcp = "${lib.getExe pkgs.git} cherry-pick";
        gd = "${lib.getExe pkgs.git} diff";
        gdc = "${lib.getExe pkgs.git} diff --cached";
        glg = "${lib.getExe pkgs.git} log --stat";
        glr = "${lib.getExe pkgs.git} pull --rebase";
        gpo = "${lib.getExe pkgs.git} push origin \"$(git symbolic-ref --short HEAD)\"";
        grh = "${lib.getExe pkgs.git} reset HEAD";
        grm = "${lib.getExe pkgs.git} rm";
        gs = "${lib.getExe pkgs.git} status";
        lg = "${lib.getExe pkgs.lazygit}";
        o = "${lib.getExe' pkgs.xdg-utils "xdg-open"}";
      };
    };
  };
}
