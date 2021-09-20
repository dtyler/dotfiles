if &term == "rxvt-unicode"
    set term=rxvt
endif

"set t_Co=256

set nocompatible
set expandtab
set backspace=2
set shiftwidth=2
set softtabstop=2
" Visuals
set showtabline=2
set scrolloff=2
set listchars=tab:>-,trail:.
set number
set showcmd
set showmatch
set incsearch
set ruler
set updatetime=100

syntax on
filetype plugin on
if has("autocmd")
  filetype plugin indent on
else
  set autoindent
endif

" Keybindings
imap jj <ESC>
nmap ; :
nnoremap ; :
nnoremap <silent> k gk
nnoremap <silent> j gj
nmap <F2> :set list!<CR>
nmap <F3> :registers<CR>
nmap <F4> :set invhls<CR>
nmap <F10> :set mouse=a<CR>
nmap <F12> :set number!<CR>
map - <C-w>-
map + <C-w>+

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
set statusline+=%1*\ %B\ %*		    "hex value of char under cursor
set statusline+=%2*%y%*	        	    "file type
set statusline+=%3*\ %<%F%*		    "full path
set statusline+=%2*%m%*		            "modified flag
set statusline+=%=%{fugitive#statusline()}  "active register
set statusline+=\ %{v:register}             "git branch
set statusline+=%1*%5l%*		    "current line
set statusline+=%2*/%L%*		    "total lines
set statusline+=%1*%4c\ %*		    "column number
set statusline+=%P			    "percent through file

"Remove trailing whitespace
autocmd FileType python,ruby autocmd BufWritePre * :%s/\s\+$//e

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

call pathogen#infect()
call pathogen#helptags()

" Gvim settings
highlight Normal guifg=green guibg=black

" Plugin options
let g:puppet_align_hashes = 0

" use bash as vim shell for RVM compatibility
set shell=bash
