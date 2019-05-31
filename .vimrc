set number

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
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'suan/vim-instant-markdown', {'rtp':'after'}



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Set split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set folding and shortcut
set foldmethod=indent
set foldlevel=99
noremap <space> za

" Specs for python files
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
	\ match BadWhitespace /\s\+$/

" Settings for YouCompleteMe	
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

