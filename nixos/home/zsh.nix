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
        'directory' \
        'history' \
        'prompt'

      zstyle ':prezto:module:prompt' theme 'pure'

      source ${pkgs.zsh-prezto}/init.zsh
    '';

    sessionVariables = {
      EDITOR = "vim";
    };

    shellAliases = {
      l  = "${pkgs.exa}/bin/exa -la";
      lt = "${pkgs.exa}/bin/exa -l --tree";
      b  = "${pkgs.bat}/bin/bat";
      md = "mkdir -p";
      v  = "vim";
    };
  };
}
