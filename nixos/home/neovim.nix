{ pkgs, ... }:

let customVimPlugins = {
  custom-nord = pkgs.vimUtils.buildVimPlugin {
    name = "nord";
    src = pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-vim";
      rev = "81d80e4a978aaab77e930b094bfb6780f695b438";
      sha256 = "1s3jd8g7xnqn9pbg4s127ai9qm7zb6nvrmww842iz8qs3nmvf60v";
    };
  };
  custom-skim = pkgs.vimUtils.buildVimPlugin {
    name = "skim";
    src = pkgs.fetchFromGitHub {
      owner = "lotabout";
      repo = "skim";
      rev = "711eab5c0031cd31a0750a7ab054a7492c33c8cc";
      sha256 = "1gj98pf0wq0lx56aaw981kcmq7a769k0lw5cjp3bancgkssk6wmz";
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
        " (plugin) skim
        " ************************************************************

        " Fuzzy find files
        nnoremap <leader>t :SK<CR>


        " ************************************************************
        " (plugin) deoplete
        " ************************************************************

        " Auto start deoplete
        let g:deoplete#enable_at_startup = 1

        " Expand an autocomplete option or jump within the current expansion
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        xmap <C-k> <Plug>(neosnippet_expand_target)
      '';

      plug.plugins = with pkgs.vimPlugins // customVimPlugins; [
        # Theme
        custom-nord

        # Fuzzy finder
        custom-skim

        # Autocompletion
        deoplete-nvim

        # Snippets
        neosnippet-vim
        neosnippet-snippets

        # Status bar
        vim-airline
        vim-airline-themes

        # Languages
        vim-nix

        # Shortcuts for working with parentheses
        vim-surround
        vim-repeat

        # Display git diff in the gutter
        vim-gitgutter
      ];
    };
  };
}
