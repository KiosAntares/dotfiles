nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nmap <C-L>d DiscordUpdatePresence

"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <C-n> :NERDTreeToggle<CR>

" Copy and paste from system clipboard using vim shortcuts

vnoremap <C-c>y "+y
nnoremap <C-c>Y "+y
nnoremap <C-c>y "+y

nnoremap <C-c>p "+p
nnoremap <C-c>P "+P
vnoremap <C-c>p "+p
vnoremap <C-c>P "+P


" Special writing remaps
inoremap <C-p>p [protagonist]
inoremap <C-p>c [coprotagonist]
inoremap <C-p>1 [character 1]
inoremap <C-p>2 [character 2]
inoremap <C-p>3 [character 3]
inoremap <C-p>4 [character 4]
inoremap <C-p>5 [character 5]
inoremap <C-p>6 [character 6]
inoremap <C-p>7 [character 7]
