{ pkgs, ... }:


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
  picker = pkgs.vimUtils.buildVimPlugin {
    name = "vim-picker";
    src = pkgs.fetchFromGitHub {
      owner = "srstevenson";
      repo = "vim-picker";
      rev = "786cc73492510062adcff47e7b92a09ccbf2a471";
      sha256 = "176rzis3rmn0vkl1swc1yxdy6paivfp08dkivlp2c1ffwqw640z2";
    };
  };
};

in {
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


        " ************************************************************
        " (plugin) picker
        " ************************************************************

        " Fuzzy find files.
        nmap <unique> <leader>t <Plug>(PickerEdit)
        " Fuzzy find buffers.
        nmap <unique> <leader>b <Plug>(PickerBuffer)
      '';

      plug.plugins = with pkgs.vimPlugins // customVimPlugins; [
        nord
        picker

        vim-airline
        vim-airline-themes
        vim-nix
        vim-surround
        vim-repeat
      ];
    };
  };
}
