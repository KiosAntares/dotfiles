set number
set relativenumber
set splitbelow
set splitright
set shell=fish
syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set showmode
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir="~/.config/nvim/undodir"
set undofile
set incsearch
set hlsearch
set inccommand=split

set cursorline
set scrolloff=5
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

set mouse+=a

"set colorcolumn=80,120
let &colorcolumn="80,".join(range(120,999),",")
"highlight ColorColumns ctermbg=1 guibg=#adadad
hi ColorColumn cterm=reverse

set hidden
set nobackup
set nowritebackup

set cmdheight=2
set updatetime=300

set shortmess+=c
set signcolumn=yes


let g:catppuccin_flavour = "mocha"
colorscheme catppuccin
let &t_ut=''

let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_enabled = 0
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
