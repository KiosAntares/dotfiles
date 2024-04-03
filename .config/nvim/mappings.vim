nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >
vmap <S-Tab> <

imap <c-Tab> <c-t>
imap <c-s-Tab> <c-d>

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <C-n> :NvimTreeToggle<CR>
nmap <C-b> :SymbolsOutline<CR>

command Py exec "!python3 %"
cnoreabbrev tb Tabularize
" C and paste from system clipboard using vim shortcuts

vnoremap <C-c>y "+y
nnoremap <C-c>Y "+Y
nnoremap <C-c>y "+y

nnoremap <C-c>p "+p
nnoremap <C-c>P "+P
vnoremap <C-c>p "+p
vnoremap <C-c>P "+P

" Movement and deletion
inoremap <C-d> <C-o>de

let mapleader = " "

nnoremap <leader>q @
nnoremap <leader>r @@
nnoremap <leader>, gT
nnoremap <leader>. gt
nnoremap <leader>b g<TAB>

noremap <leader>al :Tabularize  

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>cc <cmd>Telescope commands<cr>
nnoremap <leader>lr <cmd>Telescope lsp_references<cr>
nnoremap <leader>li <cmd>Telescope lsp_impelementations<cr>
nnoremap <leader>lt <cmd>Telescope lsp_type_definitions<cr>
nnoremap <leader>ld <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>ls <cmd>Telescope treesitter<cr>
nnoremap <leader>tt <cmd>Telescope builtin<cr>
