call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Clear old autocmds in group
autocmd!

"Set mapleader
let mapleader = ","
let g:mapleader = ","

nnoremap ; :


" Sane spacing and tabs
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab

"Set what VIM thinks of as keywords.  Used when searching and moving
set isk+=_,$,@,%,#,- 


"Basic settings############################################################
behave xterm
set nocompatible
" 100 lines of command line history
set history=100         
"when scroll down start at last 3 lines
set scrolloff=3
"set vim to use a central backup dir
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set  dictionary="/usr/dict/words"
set noerrorbells
set visualbell t_vb=
set wildmenu
set ruler
syntax on 
filetype plugin indent on
" Make backspace delete lots of things
set backspace=indent,eol,start
" 1 height windows
set winminheight=1
" better handling of background buffers
set hidden

"Status bar
set laststatus=2 "always show status
set showmode    "show current mode down the bottom
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%{rvm#statusline()}%=%-14.(%l,%c%V%)\ %P


"Shortcuts for common tasks
command! Q q " Bind :Q to :q
map <leader>w :w<cr>


"colors
set background=dark
colorscheme vividchalk

"map to bufexplorer
map <leader>b :BufExplorer<cr>


"shortbut for opening new ConqueTerm bash
map <leader>s :ConqueTermSplit<space>

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1


"Buil ctags file for rails projects 
command! BuildRubyTags :exec ":!ctags -a -e -f TAGS --tag-relative -R app lib"
:set tags=./TAGS;



" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . '/'<CR>
else
  map ,e :e <C-R>=expand("%:p:h") . '\'<CR>
endif


"-----
" select xml text to format and hit ,x
vmap <leader>x :!tidy -q -i -xml<CR> 
"--- 

"----
" run selection in bash
vmap ,r :!bash <CR>
"---


" easy indentation in visual mode
" This keeps the visual selection active after indenting.
" Usually the visual selection is lost after you indent it.
vmap > >gv
vmap < <gv

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault


" SEARCHING STUFF
" map space to starting a new search
map <space> /
"set hl search
set hlsearch
"set incsearch
set incsearch
"set ignore case for search
set ignorecase
set smartcase "be case sensitive if search has cap letter

"show partial commands in bottom line
set showcmd

"when listing user commands
com! VR :vertical resize 80

"show linenumbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkRed ctermbg=NONE gui=NONE guifg=DarkRed guibg=NONE


"make it easy to source and load vimrc
:nmap <Leader>v :e $MYVIMRC<cr>
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" A nice, minimalistic tabline
hi TabLine cterm=bold,underline ctermfg=8 ctermbg=0
hi TabLineSel cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill cterm=bold ctermbg=0


"Switch to current dir
map <leader>cd :cd %:p:h<cr>


"Toggle NERDTree
map <leader>d :NERDTreeToggle<cr>


"save as sudo
command! -bar -nargs=0 SudoW  :silent exe "write !sudo tee % >/dev/null"|silent edit!

"load some work stuff
if filereadable($HOME."/.vimrc_work")
  source $HOME/.vimrc_work
endif



