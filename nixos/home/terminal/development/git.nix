{ pkgs, ... }:

let
  settings = import ../../../settings.nix;

in {
  programs.git = {
    enable = true;
    userName = settings.user.name;
    userEmail = settings.user.email;
    signing = {
      signByDefault = true;
      key = settings.user.gpg.signingKey;
    };
  };

  programs.zsh.shellAliases = {
    g    = "${pkgs.git}/bin/git";
    ga   = "${pkgs.git}/bin/git add";
    gars = "${pkgs.git}/bin/git add . && git reset --hard";
    gc   = "${pkgs.git}/bin/git commit";
    gcm  = "${pkgs.git}/bin/git commit -m";
    gca  = "${pkgs.git}/bin/git commit --amend";
    gcp  = "${pkgs.git}/bin/git cherry-pick";
    gco  = "${pkgs.git}/bin/git checkout";
    gd   = "${pkgs.git}/bin/git diff";
    gdc  = "${pkgs.git}/bin/git diff --cached";
    glr  = "${pkgs.git}/bin/git pull --rebase";
    glg  = "${pkgs.git}/bin/git log --stat";
    grh  = "${pkgs.git}/bin/git reset HEAD";
    grm  = "${pkgs.git}/bin/git rm";
    gs   = "${pkgs.git}/bin/git status";
  };
}
