{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    exa
    zsh-prezto
  ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      zstyle ':prezto:load' pmodule \
        'environment' \
        'editor' \
        'fasd' \
        'directory' \
        'history' \
        'prompt'

      zstyle ':prezto:module:prompt' theme 'pure'

      source ${pkgs.zsh-prezto}/init.zsh

    '';

    sessionVariables = {
      SKIM_DEFAULT_COMMAND = "${pkgs.ripgrep}/bin/rg --files --hidden | grep -v '\.git'";
      SKIM_DEFAULT_OPTIONS = "--reverse --height 40%";
    };

    shellAliases = {
      g    = "${pkgs.git}/bin/git";
      ga   = "${pkgs.git}/bin/git add";
      gars = "${pkgs.git}/bin/git add . && git reset --hard";
      gc   = "${pkgs.git}/bin/git commit";
      gcm  = "${pkgs.git}/bin/git commit -m";
      gca  = "${pkgs.git}/bin/git commit --amend";
      gcp  = "${pkgs.git}/bin/git cherry-pick";
      gco  = "${pkgs.git}/bin/git checkout";
      gd   = "${pkgs.git}/bin/git diff";
      glr  = "${pkgs.git}/bin/git pull --rebase";
      glg  = "${pkgs.git}/bin/git log --stat";
      grh  = "${pkgs.git}/bin/git reset HEAD";
      grm  = "${pkgs.git}/bin/git rm";
      gs   = "${pkgs.git}/bin/git status";
      l    = "${pkgs.exa}/bin/exa -la";
      lt   = "${pkgs.exa}/bin/exa -l --tree";
      b    = "${pkgs.bat}/bin/bat";
      md   = "mkdir -p";
      v    = "vim";
    };
  };
}
