with import <nixpkgs> {};

vim_configurable.customize {
  vimrcConfig.customRC = ''
    " ************************************************************
    " General
    " ************************************************************

    " Make these files completely invisible to vim
    set wildignore+=*/.git/*,*/.hg/*,*/.sass-cache/*,*node_modules/*
    set wildignore+=*.png,*.gif,*.jpg,*.ico,*.pdf,*.DS_Store,*.pyc


    " ************************************************************
    "  Display
    " ************************************************************

    " Show line numbers
    set number

    " Show the line and column of the cursor location
    set ruler

    " Show the line and column number in the status bar
    set cursorline

    " Disable line wrapping
    set nowrap

    " Show dangling whitespace
    set list listchars=tab:\ \ ,trail:·

    " Disable code folding
    set nofoldenable

    " Disable the built in mode status.
    set noshowmode
    "
    " Show a status bar
    set laststatus=2

    " ************************************************************
    " Search
    " ************************************************************

    " Highlight all matches of the most recent search
    set hlsearch

    " Update search matches in real time
    set incsearch

    " Ignore case unless a capital letter is used
    set ignorecase
    set smartcase

    " ************************************************************
    " Editing
    " ************************************************************

    " Copy indentations from the current line to new lines
    set autoindent

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

    " Show the current command
    set showcmd

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

    " Make Y behave like other capitals
    nnoremap Y y$

    " Insert a newline above the current line
    nmap <CR> O<Esc>j

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

    " Quickly switch to insert mode from visual mode
    vnoremap a <Esc>a

    " Copy selection to the system clipboard
    vnoremap <Leader>c "*y
  '';
}
