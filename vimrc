call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
" On some Linux systems, this is necessary to make sure pathogen picks up ftdetect directories in plugins! :(
filetype off 
syntax on



" Clear old autocmds in group so we don't get warnings
autocmd!


"General behavior
set nocompatible
behave xterm

set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

  
"colors
"set background=light
"colorscheme default
set background=dark
colorscheme vividchalk


if has("gui_running")
  set guioptions=egmrt "hide macvim gui
  set guifont=Menlo:h18
endif


" Sane spacing and tabs
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab


"Set what Vim thinks of as keywords.  Used when searching and moving
set isk+=_,$,@,%,#,- 


"no error signals
set noerrorbells
set visualbell t_vb=


"General settings that make Vim awesome
filetype plugin indent on
syntax on 
set  dictionary="/usr/dict/words"
set wildmode=list:longest,full " Better completion
set wildmenu
set ruler
set autoread " auto read file if it has changed outside of vim
set history=100 " 100 lines of command line history
set scrolloff=3 "when scroll down start at last 3 lines
set hidden  "better handling of background buffers
set backspace=indent,eol,start  " Make backspace delete lots of things
set showcmd " show partial commands in bottom line

"I rarely use folds 
set nofoldenable 


"set vim to use a central backup dir
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" window behavior
set splitbelow  " Open new horizontal split windows below current
set splitright  " Open new vertical split windows to the right
set switchbuf=useopen,usetab,split  " Don't change current buffer on quickfix
set winminheight=1  " 1 height windows


"Status bar
set laststatus=2 "always show status
set showmode    "show current mode down the bottom
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P


"Linenumbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkRed ctermbg=NONE gui=NONE guifg=DarkRed guibg=NONE


" A nice, minimalistic tabline in CLI Vim
hi TabLine cterm=bold,underline ctermfg=8 ctermbg=0
hi TabLineSel cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill cterm=bold ctermbg=0


"Shortcuts for common tasks
command! Q q " Bind :Q to :q.

"Make semicolon work as colon so you don't have to push shift 
"for common actions
map ; :
"Two semicolons == semicolon
noremap ;; ;


"Make Y consistent with other cap letters (D, C)
nnoremap Y y$


" keep the visual selection active after indenting.
vmap > >gv
vmap < <gv


"cmdline
""""""""""""""""""""""""""""""""""""""""""""""""""
"cmdline mappings for Emacs style movement on cmdline
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

"Want to be able to open cmdline window buffer (normally C-F)
"but still have C-F be <Right>
set cedit=<C-Y>




" Searching Stuff
" I prever very magic (\v) search behavior
nnoremap / /\v
vnoremap / /\v
set hlsearch "set hl search
set incsearch "set incsearch
set ignorecase "set ignore case for search
set smartcase "be case sensitive if search has cap letter
set gdefault " /g flag on :s substitutions to replace all matches in a line:
nnoremap <leader><space> :noh<cr>



" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . '/'<CR>
else
  map ,e :e <C-R>=expand("%:p:h") . '\'<CR>
endif


"save as sudo
command! -bar -nargs=0 SudoW  :silent exe "write !sudo tee % >/dev/null"|silent edit!


" select xml text to format and hit ,x
vmap <leader>x :!tidy -q -i -xml<CR> 


" run selection in bash
vmap <leader>rs :!bash <CR>

" mapping to search with Ack
nnoremap <leader>a :Ack 


"make it easy to source and load vimrc
nmap <Leader>ve :e ~/.vim/vimrc<cr>
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost $HOME/.vim/vimrc source $HOME/.vim/vimrc
endif


"Ctags make the world a better place
"Based on code from https://github.com/spicycode/Vimlander-2-The-Quickening
" Add RebuildTagsFile function/command
function! s:RebuildTagsFile()
  silent !ctags -R --exclude=coverage --exclude=files --exclude=log --exclude=tmp --exclude=vendor *
endfunction
command! -nargs=0 RebuildTagsFile call s:RebuildTagsFile()

set tags=./tags;
map <Leader>rt :RebuildTagsFile<cr>


"shortcut for opening new ConqueTerm as a split
map <leader>sh :ConqueTermSplit<space>
" Continue updating shell when it's not the current, focused buffer
let g:ConqueTerm_ReadUnfocused = 1

"Command-T configuration
let g:CommandTMaxHeight=35
let g:CommandTMatchWindowAtTop=1


"""""""" NERDTree: 
" much of this is from http://github.com/spicycode/Vimlander-2-The-Quickening
map <leader>dc :NERDTreeClose<cr>
map <leader>do :NERDTree<cr>
" Enable nice colors
let NERDChristmasTree = 1
" Make it easy to see where we are
let NERDTreeHighlightCursorline = 1
" Make bookmarks visible
let NERDTreeShowBookmarks = 1
" Show hidden files
let NERDTreeShowHidden = 1
" Don't hijack NETRW
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.$', '\~$']

"Syntastic
let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=1
let g:syntastic_auto_loc_list=0


"load some work stuff
if filereadable($HOME."/.vimrc_work")
  source $HOME/.vimrc_work
endif


"Vim Wiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'path_html': '~/Dropbox/vimwiki_html/', 'auto_export': 1, 'html_header': '~/Dropbox/vimwiki_html/header.tpl'}]
map <Leader>wh  :VimwikiAll2HTML<cr>
map <Leader>wo  :!open ~/Dropbox/vimwiki_html/index.html<cr>


