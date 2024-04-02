{ pkgs, lib, ... }:

{
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

    # environment loading
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [ "--reverse" "--height 40%" ];
    };

    # git ui
    lazygit.enable = true;

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
      signing = {
        signByDefault = true;
        key = "BF2AD40D0652EF0B";
      };
      userName = "Shanon McQuay";
      userEmail = "hi@shan.dog";
    };

    # text editing
    neovim = {
      enable = true;

      extraPackages = with pkgs; [
        nodejs # runtime (copilot)
        zig # compiler (tree-sitter)
      ];

      # disable language integrations
      withRuby = false;
      withNodeJs = false;
      withPython3 = false;
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
        be = "bundle exec";
        ber = "bundle exec rspec";
        berc = "bundle exec rails console";
        bers = "bundle exec rails server";
        bi = "bundle install";
        bu = "bundle update";
        g = "${pkgs.git}/bin/git";
        ga = "${pkgs.git}/bin/git add";
        gars = "${pkgs.git}/bin/git add . && git reset --hard";
        gc = "${pkgs.git}/bin/git commit";
        gca = "${pkgs.git}/bin/git commit --amend";
        gcm = "${pkgs.git}/bin/git commit -m";
        gco = "${pkgs.git}/bin/git checkout";
        gcp = "${pkgs.git}/bin/git cherry-pick";
        gd = "${pkgs.git}/bin/git diff";
        gdc = "${pkgs.git}/bin/git diff --cached";
        glg = "${pkgs.git}/bin/git log --stat";
        glr = "${pkgs.git}/bin/git pull --rebase";
        gpo = "${pkgs.git}/bin/git push origin \"$(git symbolic-ref --short HEAD)\"";
        grh = "${pkgs.git}/bin/git reset HEAD";
        grm = "${pkgs.git}/bin/git rm";
        gs = "${pkgs.git}/bin/git status";
        j = "z";
        l = "${pkgs.eza}/bin/eza -la --icons --no-permissions --no-user";
        la = "${pkgs.eza}/bin/eza -la";
        lg = "${pkgs.lazygit}/bin/lazygit";
        ll = "${pkgs.eza}/bin/eza -la --icons";
        lt = "${pkgs.eza}/bin/eza -l --tree";
        md = "mkdir -p";
        o = "xdg-open";
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
