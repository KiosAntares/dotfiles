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

set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch

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

let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
let bufferline.icon_custom_colors = v:true
