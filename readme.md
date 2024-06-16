# My system configuration

System and user configuration for [NixOS](https://nixos.org/).

## Desktop

* [1password](https://1password.com/) (secret manager)
  * [git signing](https://developer.1password.com/docs/ssh/git-commit-signing/)
  * [ssh](https://developer.1password.com/docs/ssh/)
* [hyprland](https://hyprland.org/) (window manager)
* [kitty](https://sw.kovidgoyal.net/kitty/) (terminal multiplexer)
* [obsidian](https://obsidian.md/) (knowledge management)

Applications are themed using [stylix](https://github.com/danth/stylix)

## Terminal

* [bat](https://github.com/sharkdp/bat) (cat replacement)
* [dust](https://github.com/bootandy/dust) (du replacement)
* [eza](https://eza.rocks/) (ls replacement)
* [fd](https://github.com/sharkdp/fd) (find replacement)
* [ripgrep](https://github.com/BurntSushi/ripgrep) (grep replacement)
* [xsv](https://github.com/BurntSushi/xsv) (csv toolkit)
* [zoxide](https://github.com/ajeetdsouza/zoxide) (cd replacement)
* [zsh](https://github.com/sorin-ionescu/prezto) (shell)

## Editor

* [neovim](https://neovim.io/)
* [nixvim](https://github.com/nix-community/nixvim)

## Installation

* boot the [nixos installer](https://nixos.org/download/).

```
git clone https://github.com/compactcode/dot-files.git

cd dot-files

export NIX_CONFIG="experimental-features = nix-command flakes"

sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake '.#prophet' --disk main /dev/disk/by-uuid/faf3866c-2bdb-4b87-a9d0-96bb2271f294

sudo nixos-install --flake ".#prophet"
```
