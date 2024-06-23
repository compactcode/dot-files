{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cli/zellij
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
    # cat replacement
    bat = {
      enable = true;
    };

    # top replacement
    btop.enable = true;

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

    # json manipulation
    jq.enable = true;

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
        be = "bundle exec";
        ber = "bundle exec rspec";
        berc = "bundle exec rails console";
        bers = "bundle exec rails server";
        bi = "bundle install";
        bu = "bundle update";
        f = "${lib.getExe pkgs.fzf}";
        g = "${lib.getExe pkgs.git}";
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
        l = "${lib.getExe pkgs.eza} -la --icons --no-permissions --no-user";
        la = "${lib.getExe pkgs.eza} -la";
        lg = "${lib.getExe pkgs.lazygit}";
        ll = "${lib.getExe pkgs.eza} -la --icons";
        lt = "${lib.getExe pkgs.eza} -l --tree";
        md = "${lib.getExe' pkgs.coreutils "mkdir"} -p";
        o = "${lib.getExe' pkgs.xdg-utils "xdg-open"}";
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
