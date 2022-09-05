" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=a                 " middle-click paste with mouse
set hlsearch                " highlight search results
set autoindent              " indent a new line the same amount as the line just typed
set autowrite               " automatically save before commands like :next and :makea
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set colorcolumn=0           " nobody likes the color column

" specify directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'ellisonleao/glow.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'andweeb/presence.nvim'

" initialize plugin system
call plug#end()

" vim-airline
let g:airline_powerline_fonts = 1

" syntax stuff
syntax enable
filetype plugin indent on

" map leader
let g:mapleader = ','

" colorscheme
autocmd vimenter * ++nested colorscheme gruvbox
let g:airline_theme='gruvbox'

" gui font
set guifont=FiraCode\ Nerd\ Font:h14

" config options for neovide
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_transparency=0.9
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    let g:neovide_scroll_animation_length = 0.1
    let g:neovide_cursor_animation_length = 0.1
    let g:neovide_cursor_trail_length=0.6
    let g:neovide_cursor_vfx_mode = "railgun"
endif

" config created by electron271
