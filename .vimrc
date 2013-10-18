if &term == "rxvt-unicode"
    set term=rxvt
endif

"set t_Co=256 

set nocompatible
set smartindent
set expandtab
set backspace=2
" Visuals
set showtabline=2
set scrolloff=2
set listchars=tab:>-,trail:-
set number
set showcmd
set showmatch
set incsearch
set ruler

syntax on
filetype plugin on

" Tab Characters
set softtabstop=4
set shiftwidth=4

" Keybindings
imap jj <ESC>
nnoremap ; :
vnoremap ; :
nmap <F2> :set list!<CR>
nmap <F3> :registers<CR>
nmap <F4> :set invhls<CR>
nmap <F6> :colorscheme desert256<CR>
nmap <F7> :colorscheme desert<CR>
nmap <F12> :set number!<CR>
map - <C-w>- 
map + <C-w>+ 
ab bufs buffers

" Deal With term
if &term =~ "^screen" || &term =~ "^putty" || &term =~ "^rxvt-unicode"
    set t_Co=256
    set background=dark
elseif &term =~ "^vt100"
    set background=light
else
    set background=dark
endif

" statusline
set laststatus=2
set statusline=
set statusline +=%1*\ %n\ %*		"buffer number
set statusline +=%3*%y%*		"file type
set statusline +=%4*\ %<%F%*		"full path
set statusline +=%2*%m%*		"modified flag
set statusline +=%=%{v:register}	"active register
set statusline +=%1*%5l%*		"current line
set statusline +=%2*/%L%*		"total lines
set statusline +=%1*%4c\ %*		"column number
set statusline +=%P			"percent through file

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
endif
" Gvim settings
highlight Normal guifg=green guibg=black

"disable acp 
let g:loaded_acp = 1
