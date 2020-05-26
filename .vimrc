set number
set shell=/bin/zsh
set splitbelow
set splitright

" Set powerline status bar
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" Set visible status bar
set ls=2
" Set syntax highligting to on
syntax on

autocmd FileType javascript set local equalprg=js-beautify\ --stdin

set nocompatible              " required
filetype off                  " required
filetype plugin on

" set the runtime path to include Vundle and initialize
filetype plugin indent on    " required

" Set split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-\> <C-W><X>
" nnoremap <C-S-L> :tabm +1<CR>
" nnoremap <C-S-H> :tabm -1<CR>

" Set folding and shortcut
set foldmethod=indent
set foldlevel=99
noremap <space> za

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Specs for python files
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix   

" Settings for YouCompleteMe	
