set termguicolors
set number
set splitbelow
set splitright
set shell=/bin/zsh
syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hidden
set nobackup
set nowritebackup

set cmdheight=2
set updatetime=300


set shortmess+=c

set signcolumn=yes

let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_enabled = 0
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
