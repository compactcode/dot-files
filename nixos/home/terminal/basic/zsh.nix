{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
      zstyle ':prezto:load' pmodule \
        'environment' \
        'editor' \
        'directory' \
        'history' \
        'prompt'

      zstyle ':prezto:module:prompt' theme 'pure'

      PURE_GIT_PULL=0

      source ${pkgs.zsh-prezto}/init.zsh
    '';

    sessionVariables = {
      EDITOR = "vim";
    };

    shellAliases = {
      b  = "${pkgs.bat}/bin/bat";
      l  = "${pkgs.exa}/bin/exa -la";
      lt = "${pkgs.exa}/bin/exa -l --tree";
      md = "mkdir -p";
      o = "xdg-open";
      v  = "vim";
    };
  };
}
