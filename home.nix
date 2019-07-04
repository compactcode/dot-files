{ pkgs, ... }:

{

  home.packages = [
    pkgs.ripgrep
    pkgs.skim
  ];

  programs.neovim = {
    enable = true;
	  vimAlias = true;
  };

}
