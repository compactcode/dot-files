{ config, pkgs, ... }:

let customVimPlugins = {
  nord = pkgs.vimUtils.buildVimPlugin {
    name = "nord";
    src = pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-vim";
      rev = "81d80e4a978aaab77e930b094bfb6780f695b438";
      sha256 = "1s3jd8g7xnqn9pbg4s127ai9qm7zb6nvrmww842iz8qs3nmvf60v";
    };
  };
};

in {
  system.stateVersion = "19.03";

  imports =
    [
      # NOTE: Run `nixos-generate-config` to generate.
      ./hardware-configuration.nix
      # NOTE: Requires git to be installed before `nixos-install` will work.
      "${builtins.fetchGit {
        ref = "release-19.03";
        url = "https://github.com/rycee/home-manager";
      }}/nixos"
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };
    systemd-boot = {
      enable = true;
    };
  };

  networking.hostName = "nixbox";

  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
    bat
    exa
    firefox
    git
    ripgrep
    zsh
  ];

  services.xserver = {
    enable = true;
    desktopManager = {
      default = "xfce";
      xterm = {
        enable = false;
      };
      xfce = {
        enable = true;
      };
    };
  };

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      root = {
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
      shandogs = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };

  home-manager.users.shandogs = { pkgs, ... }: {
    home.packages = with pkgs; [
      zsh-prezto
    ];

    imports = [
      ./home/alacritty.nix
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
        SKIM_DEFAULT_COMMAND = "rg --files --hidden | grep -v '\.git'";
        SKIM_DEFAULT_OPTIONS = "--reverse --height 40%";
      };
      shellAliases = {
        g    = "git";
        gars = "git add . && git reset --hard";
        gc   = "git commit";
        gca  = "git commit --amend";
        gcp  = "git cherry-pick";
        gco  = "git checkout";
        gd   = "git diff";
        glr  = "git pull --rebase";
        glg  = "git log --stat";
        grh  = "git reset --HEAD";
        gs   = "git status";
        l    = "exa -la";
        md   = "mkdir -p";
      };
    };

    programs.git = {
      enable = true;
      userName = "Shanon McQuay";
      userEmail = "shanonmcquay@gmail.com";
      extraConfig = {
        github = {
          username = "compactcode";
        };
      };
    };

    programs.neovim = {
      enable = true;
      vimAlias = true;
      configure = {
        customRC = ''
          " ************************************************************
          "  Display
          " ************************************************************

          " Show line numbers
          set number

          " Disable line wrapping
          set nowrap

          " Show dangling whitespace
          set list listchars=tab:\ \ ,trail:·

          " Disable code folding
          set nofoldenable

          " Use the nord colorscheme
          colorscheme nord

          " ************************************************************
          " Editing
          " ************************************************************

          " Use spaces intead of tabs
          set expandtab
          set tabstop=2
          set softtabstop=2
          set shiftwidth=2

          " Don't let vim manage backups
          set nobackup
          set nowritebackup
          set noswapfile

          " Allow buffers to be backgrounded without saving
          set hidden

          " ************************************************************
          " Search
          " ************************************************************

          " Ignore case unless a capital letter is used
          set ignorecase
          set smartcase


          " ************************************************************
          " Leader key
          " ************************************************************

          " Use a leader key closer to the home row
          let mapleader = ','


          " ************************************************************
          " Normal mode key bindings
          " ************************************************************

          " Quickly switch between split windows
          noremap <C-h> <C-w>h
          noremap <C-j> <C-w>j
          noremap <C-k> <C-w>k
          noremap <C-l> <C-w>l

          " Make Y behave like D
          nnoremap Y y$

          " Quickly insert whitespace in normal mode
          nnoremap <Space> i<Space><Esc>l

          " Quickly save all files and re run the last command
          nnoremap ! :wa<CR>:!!<CR>

          " Quickly save all files and exit vim
          nnoremap Q :wa<CR>ZZ

          " Clear search highlights
          nnoremap <Leader>, :nohlsearch<CR>


          " ************************************************************
          " Insert mode key bindings
          " ************************************************************

          " Quickly exit insert mode
          inoremap kj <Esc> :update<CR>


          " ************************************************************
          " Visual mode key bindings
          " ************************************************************

          " Copy selection to the system clipboard
          vnoremap <Leader>c "+y
        '';
        plug.plugins = with pkgs.vimPlugins // customVimPlugins; [
          nord

          vim-airline
          vim-airline-themes
          vim-nix
          vim-surround
          vim-repeat
        ];
      };

    };

    programs.skim = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
