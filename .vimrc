if &term == "rxvt-unicode"
    set term=rxvt
endif

"set t_Co=256 

set nocompatible
set number
set showcmd
set showmatch
set incsearch
set smartindent
set expandtab
set backspace=2
set ruler
set softtabstop=4
set shiftwidth=4
map - <C-w>- 
map + <C-w>+ 
colorscheme inkpot

nmap <F2> :colorscheme desert256<CR>
nmap <F3> :colorscheme desert<CR>
nmap <F4> :set invhls<CR>
imap jj <ESC>
nmap ; :

syntax on
filetype plugin on
