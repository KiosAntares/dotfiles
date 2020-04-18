
call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree',             { 'on' : 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree-git-plugin',  { 'on' : 'NERDTreeToggle' }
Plug 'tpope/vim-surround'               
Plug 'lervag/vimtex',                   { 'for': 'tex' }
Plug 'junegunn/goyo.vim'

Plug 'dylanaraps/wal.vim'

call plug#end()
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/settings.vim
source ~/.config/nvim/autocmds.vim

colorscheme wal
