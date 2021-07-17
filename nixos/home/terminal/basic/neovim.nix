{ pkgs, config, ... }:

let customVimPlugins = {
  alternate-vim-custom = pkgs.vimUtils.buildVimPlugin {
    name = "alternate-";
    src = pkgs.fetchFromGitHub {
      owner = "compactcode";
      repo = "alternate.vim";
      rev = "1686379566665f9d4b633ca47dba59d83e119a62";
      sha256 = "07d5k3sg0rbvwfgwbx72a2wvlcdgx5ik1i588kf03p0dqn2ga444";
    };
  };
  nord-nvim-custom = pkgs.vimUtils.buildVimPlugin {
    name = "nord-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "shaunsingh";
      repo = "nord.nvim";
      rev = "6860c64a3002f6dbcf36c0baf7bda8c34c5083c8";
      sha256 = "0a036xgsklqv2zwlcpyhdrip8mvgqhyb4vcsp7gwp5241917bia3";
    };
  };
  open-vim-custom = pkgs.vimUtils.buildVimPlugin {
    name = "open";
    src = pkgs.fetchFromGitHub {
      owner = "compactcode";
      repo = "open.vim";
      rev = "5fc9cdf41989a28c0d5ad01d59b2e3d5468822df";
      sha256 = "0syl8d58y2ghhd5hi06ci0zc7fc5hy85f37p7q6542p5d2whqdj9";
    };
  };
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

    withRuby = false;
    withPython3 = false;

    vimAlias = true;

    plugins = with pkgs.vimPlugins // customVimPlugins; [
      # Autocompletion
      nvim-compe

      # Snippets
      vim-vsnip
      friendly-snippets

      # Linting
      neomake

      # Syntax highlighting
      nvim-treesitter
      nvim-treesitter-textobjects

      # Fuzzy finder
      telescope-nvim

      # [dep] lualine
      # [dep] nvim-tree
      # [dep] telescope
      nvim-web-devicons

      # [dep] telescope
      plenary-nvim

      # [dep] telescope
      popup-nvim

      # File browser
      nvim-tree-lua

      # Theme
      nord-nvim-custom

      # Fuzzy finder
      fzf-vim

      # Status bar
      lualine-nvim

      # Languages (not supported by tree-sitter)
      vim-slim-custom

      # Preview colors inline
      vim-css-color

      # Shortcuts for working with parentheses
      vim-surround
      vim-repeat

      # Display git diff in the gutter
      vim-gitgutter

      # Utils for finding source/test files
      alternate-vim-custom
      # Utils for opening files
      open-vim-custom

      # Make it easier to run test files in a terminal
      vim-test
    ];

    extraPackages = with pkgs; [
      gcc # Add a C compiler for tree-sitter
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

      " Open a git history viewer with the current file.
      nnoremap <Leader>g :silent ! ${pkgs.alacritty}/bin/alacritty -e ${pkgs.tig}/bin/tig log % &<CR>

      " Switch between test and implementation files
      nnoremap <Leader>a :Open(alternate#FindAlternate())<CR>
      nnoremap <Leader>h :OpenHorizontal(alternate#FindAlternate())<CR>
      nnoremap <Leader>v :OpenVertical(alternate#FindAlternate())<CR>

      " ************************************************************
      " Insert mode key bindings
      " ************************************************************

      " Quickly exit insert mode and save any changes.
      inoremap kj <Esc> :update<CR>


      " ************************************************************
      " Visual mode key bindings
      " ************************************************************

      " Copy selection to the system clipboard
      vnoremap <Leader>c "+y


      " ************************************************************
      " Terminal mode key bindings
      " ************************************************************

      " Quickly exit insert mode.
      tmap <C-o> <C-\><C-n>

      " ************************************************************
      " (plugin) fzf
      " ************************************************************

      " Quickly repeat previous searches.
      let g:fzf_history_dir = '${config.xdg.dataHome}/fzf/.fzf-history'


      " ************************************************************
      " (plugin) fzf + fre
      " ************************************************************

      " Record edited files
      autocmd BufNewFile,BufRead * ! ${config.xdg.dataHome}/bin/recently-edited-add <amatch>

      " Fuzzy find recently edited files
      nnoremap <leader>f :call fzf#run(fzf#wrap({
        \ 'source':  '${config.xdg.dataHome}/bin/recently-edited-list',
        \ 'options': '--no-sort --tiebreak=index'
        \ }))<CR>


      " ************************************************************
      " (plugin) vsnip
      " ************************************************************

      imap <expr> <C-k> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      smap <expr> <C-k> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

      " ************************************************************
      " (plugin) compe
      " ************************************************************

      lua <<EOF
        vim.o.completeopt = "menuone,noselect"

        require('compe').setup {
          enabled = true;
          autocomplete = true;
          preselect = 'enable';
          documentation = true;

          source = {
            path = true;
            buffer = true;
            nvim_lsp = true;
            vsnip = true;
          };
        }
      EOF

      " Accept the completion.
      inoremap <silent><expr> <CR> compe#confirm('<CR>')

      " ************************************************************
      " (plugin) lualine
      " ************************************************************

      lua <<EOF
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'nord',
            component_separators = {'|', '|'},
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {{'filename', file_status = true, path = 1}},
            lualine_x = {'encoding', 'fileformat', {'filetype', colored = false}},
            lualine_y = {'progress'},
            lualine_z = {'location'}
          },
        }
      EOF


      " ************************************************************
      " (plugin) neomake
      " ************************************************************

      " Run linting automatically.
      autocmd VimEnter * call neomake#configure#automake('nrwi', 500)


      " ************************************************************
      " (plugin) nord.nvim
      " ************************************************************

      lua <<EOF
        vim.g.nord_contrast = false
        vim.g.nord_borders = true
        vim.g.nord_disable_background = false

        require('nord').set()

        vim.cmd('highlight link CompeDocumentation Pmenu')
      EOF


      " ************************************************************
      " (plugin) nvim-tree
      " ************************************************************

      let g:nvim_tree_width = 40
      let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]

      nnoremap <Leader>o :NvimTreeFindFile<CR>


      " ************************************************************
      " (plugin) telescope
      " ************************************************************

      lua <<EOF
        local actions = require('telescope.actions')

        require('telescope').setup {
          defaults = {
            mappings = {
              i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
              }
            },
            vimgrep_arguments = {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case'
            },
            layout_strategy = "horizontal",
            prompt_prefix = "> ",
            selection_caret = "> ",
            entry_prefix = "  ",
            initial_mode = "insert",
            sorting_strategy = "ascending",
            file_sorter =  require'telescope.sorters'.get_fzy_sorter,
            color_devicons = false,
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
          }
        }
      EOF

      " Fuzzy find files
      nnoremap <leader>t :Telescope find_files<CR>

      " Find the current word within the current directory.
      nnoremap <leader>s :Telescope grep_string<CR>

      " ************************************************************
      " (plugin) tree-sitter
      " ************************************************************

      autocmd BufRead,BufNewFile *.nix setf nix

      lua <<EOF
        require('nvim-treesitter.configs').setup {
          ensure_installed = "maintained",

          highlight = {
            enable = true,
            custom_captures = {
              ["symbol"] = "TSVariable",
            },
          },

          indent = {
            enable = false
          },

          textobjects = {
            select = {
              enable = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
              },
            },
          },
        }
      EOF

      " ************************************************************
      " (plugin) vim-test
      " ************************************************************

      " Run tests in a terminal split.
      let test#strategy = "neovim"

      " Run the current file.
      nnoremap <leader>r :TestFile<CR>

      " Run the selected test within the current file.
      nnoremap <leader>n :TestNearest<CR>

      " Save the current file and re-run the most recent test.
      nnoremap ! :update<CR>:TestLast<CR>
    '';
  };
}
