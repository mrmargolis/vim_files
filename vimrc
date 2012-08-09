call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" On some Linux systems, this is necessary to make sure pathogen picks up ftdetect directories in plugins! :(
filetype off

" Clear old autocmds in group so we don't get warnings on reloading vimrc
autocmd!

"General behavior
behave xterm

"Set mapleader
let mapleader = ","
let g:mapleader = ","
let localleader = '\'

"colors
"set background=light
"colorscheme default
colorscheme vividchalk
set background=dark
if $TERM == '^\%(screen\|xterm-color\)$' && t_Co == 8
  set t_Co=256
endif


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
set ruler " show line and column position
set autoread " auto read file if it has changed outside of vim
set history=100 " 100 lines of command line history
set scrolloff=3 "when scroll down start at last 3 lines
set hidden  "better handling of background buffers
set backspace=indent,eol,start  " Make backspace delete lots of things
set showcmd " show partial commands in bottom line
set cmdheight=2
set mouse=a " sometimes (rarely) a mouse is a good thing
set nofoldenable " I rarely use folds

"remove included file searching for completions.
"http://stackoverflow.com/questions/2169645/vims-autocomplete-is-excruciatingly-slow
set complete-=i

set timeoutlen=3000 "wait this long for mappings
set ttimeoutlen=50 "Make Esc work faster


"set vim to use a central backup dir
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" window behavior
set splitbelow  " Open new horizontal split windows below current
set splitright  " Open new vertical split windows to the right
set switchbuf=useopen,usetab ",split  " Don't change current buffer on quickfix
set winminheight=1  " 1 height windows


"Status bar
set laststatus=2 "always show status
set showmode    "show current mode down the bottom
set statusline=%<%f\ %h%m%r%{rvm#statusline()}%=%-14.(%l,%c%V%)\ %P


"Linenumbers on the left side of screen.  I like red numbers
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

"Two semicolons == semicolon for repeating last T/t/F/f 
noremap ;; ;

"map ,, to jump to last file
map <leader><leader> <C-^>


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
nnoremap <leader><space> :noh<cr>  " remove highlight from search matches



" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . '/'<CR>
else
  map ,e :e <C-R>=expand("%:p:h") . '\'<CR>
endif


"save as sudo with :SudoW
command! -bar -nargs=0 SudoW :setl nomod|silent exe 'write !sudo tee % >/dev/null'|let &mod = v:shell_error

"Copy current Vim paste register to clipboard
map <F2> :PBCopy<cr>

"Toggle between paste and nopaste, shows which one is active
map <F3> :set paste!\|set paste?<cr>

" select xml text to format and hit ,x
vmap <leader>x :!tidy -q -i -xml<CR>
" select json text to format and hit ,j
vmap <leader>j :!python -mjson.tool<CR>

" run selection in bash
vmap <leader>rs :!bash <CR>

" mapping to search with Ack
nnoremap <leader>a :Ack
" mapping to search for word under cursor with Ack
nnoremap <leader>A :Ack <C-R><C-W><CR>


"make it easy to source and load vimrc
:nnoremap <leader>ve :vsplit $MYVIMRC<cr>
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost $HOME/.vim/vimrc source $HOME/.vim/vimrc
  autocmd bufwritepost $HOME/.vimrc source $HOME/.vim/vimrc
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


"Command-T configuration
let g:CommandTMaxHeight=35
let g:CommandTMatchWindowAtTop=1
map <leader>t :CommandTFlush<cr>\|:CommandT<cr>
map <leader>T :tabnew\|:CommandTFlush<cr>\|:CommandT<cr>



"""""""" NERDTree:
" much of this is from http://github.com/spicycode/Vimlander-2-The-Quickening
map <leader>dc :NERDTreeClose<cr>
map <leader>do :NERDTree<cr>
map <leader>df :NERDTreeFind<cr>
" Enable nice colors
let NERDChristmasTree = 1
" Make it easy to see where we are
let NERDTreeHighlightCursorline = 1
" Make bookmarks visible
let NERDTreeShowBookmarks = 1
" Show hidden files
let NERDTreeShowHidden = 1
" Don't hijack NETRW
"let NERDTreeHijackNetrw = 0
let NERDTreeHijackNetrw = 1
let NERDTreeIgnore=['\.$', '\~$']

"Syntastic.  Awesome syntax error checking for js, ruby, etc...
let g:syntastic_enable_signs=1 "show markers next to each error/warning
let g:syntastic_auto_loc_list=0 "don't pop up the Errors list automatically


"load some work stuff
if filereadable($HOME."/.vimrc_work")
  source $HOME/.vimrc_work
endif


let vimclojure#WantNailgun = 1

"Vim Wiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'path_html': '~/Dropbox/vimwiki_html/', 'auto_export': 1, 'html_header': '~/Dropbox/vimwiki_html/header.tpl'}]
map <Leader>wh  :VimwikiAll2HTML<cr>
map <Leader>wo  :!open ~/Dropbox/vimwiki_html/index.html<cr>

" Trim command to remove random whitespace.
command! -bar -range=% Trim :<line1>,<line2>s/\s\+$//e

" \\ To comment and uncomment a line
nmap \\ <Plug>NERDCommenterInvert
xmap \\ <Plug>NERDCommenterInvert

" rdebug abbreviation to get ruby debug line
iabbrev rdebug require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger

"Came up with this when @garybernhardt asked for a port of
"emacs' scroll-other-window command on twitter
"He added the count arg
function! ScrollOtherWindowDown(count)
  normal! 
  normal! 
  normal! 
endfunction
function! ScrollOtherWindowUp(count)
  normal! 
  normal! 
  normal! 
endfunction
nnoremap g<c-y> :call ScrollOtherWindowUp(v:count)<cr>
nnoremap g<c-e> :call ScrollOtherWindowDown(v:count)<cr>

" Command to jump to hosts file
command! Edithosts :e /etc/hosts


" From https://bitbucket.org/sjl/dotfiles/src/1b6ffba66e9f/vim/.vimrc#cl-1023
" }}}
" Next and Last {{{

" Motion for "next/last object". For example, "din(" would go to the next "()" pair
" and delete its contents.

onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "d"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" }}}

let g:ctrlp_working_path_mode = 2
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_max_height = 50

" Turn the current split into a new tab
" Written for Chris Johnson to show how to turn a split into a new tab
function! SplitToTab()
  :tab split
  :normal! gT
  :q
  :normal! gt
endfunction
command! -nargs=0 SplitToTab call SplitToTab()

" I don't need time that often, but when I do I hate having to remember how to
" get it
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
