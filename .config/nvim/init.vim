
call plug#begin(stdpath('data') . '/plugged')

"--- Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"--- Filetree
Plug 'scrooloose/nerdtree',             { 'on' : 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree-git-plugin',  { 'on' : 'NERDTreeToggle' }

"--- Utilities
Plug 'jremmen/vim-ripgrep'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'skammer/vim-css-color'
Plug 'chrisbra/csv.vim'

"--- Tpope's utilities
Plug 'tpope/vim-surround'               
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'

"--- Language specific plugins
Plug 'lervag/vimtex',                   { 'for': 'tex' }

"--- Colorschemes && Style
Plug 'vim-airline/vim-airline'
Plug 'dylanaraps/wal.vim'

"--- Random plugins
Plug 'junegunn/goyo.vim'
Plug 'aurieh/discord.nvim'

"

call plug#end()

colorscheme wal

source ~/.config/nvim/mappings.vim
source ~/.config/nvim/settings.vim
source ~/.config/nvim/autocmds.vim
source ~/.config/nvim/commands.vim
