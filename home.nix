{ pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "22.11";
  };

  programs = {
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
        v    = "nvim";
      };
    };
  };
}
