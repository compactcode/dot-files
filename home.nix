{ pkgs, lib, ... }:

{
  home = {
    sessionVariables = {
      # Use nvim as the default editor.
      EDITOR = "nvim";
      # Replace ssh with the system gpg agent.
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";
      # Use nvim as the default editor.
      VISUAL = "nvim";
    };
    stateVersion = "22.11";
  };

  programs = {
    # version control.
    git = {
      enable = true;
      # use delta for nice diff output.
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
        key = "BF2AD40D0652EF0B";
      };
      userName = "Shanon McQuay";
      userEmail = "hi@shan.dog";
    };

    # fuzzy finder.
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
      defaultOptions = [
        "--reverse"
          "--height 40%"
      ];
    };

    # shell prompt.
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # shell.
    zsh = {
      enable = true;

      prezto = {
        enable = true;

        pmodules = [
          "completion" # auto completion
          "directory" # auto pushd/popd 
          "editor"  # emacs key bindings
          "history" # history setup
        ];
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
        l    = "${pkgs.exa}/bin/exa -la --icons --no-permissions --no-user";
        la   = "${pkgs.exa}/bin/exa -la";
        ll   = "${pkgs.exa}/bin/exa -la --icons";
        lt   = "${pkgs.exa}/bin/exa -l --tree";
        md   = "mkdir -p";
        o    = "xdg-open";
        v    = "nvim";
      };
    };
  };
}
