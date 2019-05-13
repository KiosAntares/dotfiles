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
