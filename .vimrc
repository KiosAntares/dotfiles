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
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'suan/vim-instant-markdown', {'rtp':'after'}
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'yggdroot/indentline'
Plugin 'ap/vim-css-color'
Plugin 'chrisbra/csv.vim'
Plugin 'sickill/vim-monokai'
Plugin 'vim-scripts/taglist.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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

" Settings for TagTree
nnoremap <silent> <C-t> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window = 1

"Settings for vim-instant-markdown
"let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 1
"let g:instant_markdown_open_to_the_world = 1 
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_allow_external_content = 1
"let g:instant_markdown_mathjax = 1

" Settings for NERDTree
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
