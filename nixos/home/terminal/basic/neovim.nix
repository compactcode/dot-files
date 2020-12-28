{ pkgs, config, ... }:

let customVimPlugins = {
  vim-slim-custom = pkgs.vimUtils.buildVimPlugin {
    name = "vim-slim";
    src = pkgs.fetchFromGitHub {
      owner = "slim-template";
      repo = "vim-slim";
      rev = "f0758ea1c585d53b9c239177a8b891d8bbbb6fbb";
      sha256 = "0vqfn3638fi1i1m5dbglfg02qdgkqkf5ap224bp0695l33256hbn";
    };
  };
};

in {
  programs.neovim = {
    enable = true;

    vimAlias = true;

    plugins = with pkgs.vimPlugins // customVimPlugins; [
      # Autocompletion
      deoplete-nvim

      # Snippets
      neosnippet-vim
      neosnippet-snippets

      # Theme
      nord-vim

      # Fuzzy finder
      skim-vim

      # Status bar
      vim-airline
      vim-airline-themes

      # Languages
      vim-nix
      vim-slim-custom

      # Preview colors inline.
      vim-css-color

      # Shortcuts for working with parentheses
      vim-surround
      vim-repeat

      # Display git diff in the gutter
      vim-gitgutter
    ];

    extraConfig = ''
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
      nnoremap <space> i<space><Esc>l

      " Quickly save all files and re run the last command
      nnoremap ! :wa<CR>:!!<CR>

      " Quickly save all files and exit vim
      nnoremap Q :wa<CR>ZZ

      " Clear search highlights
      nnoremap <Leader>, :nohlsearch<CR>

      " Open a file browser in the directory of the current file.
      nnoremap <Leader>o :silent ! ${pkgs.alacritty}/bin/alacritty -e ${pkgs.lf}/bin/lf %:h &<CR>

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
      " (plugin) skim + fre
      " ************************************************************

      " Record edited files
      autocmd BufNewFile,BufRead * ! ${config.xdg.dataHome}/bin/recently-edited-add <amatch>

      " Fuzzy find recently edited files
      nnoremap <silent> <leader>f :call skim#run(skim#wrap('SKIM', {
        \ 'source':  '${config.xdg.dataHome}/bin/recently-edited-list',
        \ 'down':    '40%',
        \ 'options': '-no-sort --tiebreak=index'
        \ }))<CR>


      " ************************************************************
      " (plugin) skim + rg
      " ************************************************************

      " A function to edit a file from a rg search result.
      "
      " e.g: rg --column --no-heading bundler
      "
      " => config/boot.rb:3:10:require 'bundler/setup' # Set up gems listed in the Gemfile.
      function! s:OpenRgResult(selected_line)
        let file   = split(a:selected_line, ":")[0]
        let row    = split(a:selected_line, ":")[1]
        let column = split(a:selected_line, ":")[2]

        execute 'edit' . ' ' . file
        execute row
        normal! column . '|'
        normal! zz
      endfunction

      " Configure ripgrep to output single line results in color
      let s:sk_rg_source = 'rg --column --no-heading --smart-case --color always %s'

      " Configure skim to handle color and show a preview of results
      let s:sk_rg_options = '--ansi --preview "${config.xdg.dataHome}/bin/rg-sk-preview.sh {}"'

      " Configure skim to use our custom function when a result is selected.
      let s:sk_rg_sink = function('s:OpenRgResult')

      " Find current word in project
      command! -nargs=1 Rg call skim#run(skim#wrap('SKIM', {
        \ 'source':  printf(s:sk_rg_source, <f-args>),
        \ 'down':    '40%',
        \ 'options': s:sk_rg_options,
        \ 'sink':    s:sk_rg_sink
        \ }))

      nnoremap <leader>s :Rg<space>


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
  };

  # Preview ripgrep results in a skim window.
  xdg.dataFile."bin/rg-sk-preview.sh" = {
    executable = true;
    source = ../../bin/rg-sk-preview.sh;
  };
}
