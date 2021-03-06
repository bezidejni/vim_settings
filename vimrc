filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set nocompatible

" Security
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set laststatus=2
set pastetoggle=<F4>

" Leader
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
map <leader><space> :noh<cr>
runtime macros/matchit.vim
" nmap <tab> %
" vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

" Color scheme (terminal)
syntax on
set background=dark
colorscheme molokai

" NERD Tree
map <F1> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']

" Buffer Explorer
map <F5> :BufExplorer<cr>

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

" Folding
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
au BufNewFile,BufRead *.html map <leader>ft Vatzf

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" Sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>


" Ack
map <leader>a :Ack 

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" Formatting, TextMate-style
map <leader>q gqip

nmap <leader>m :make<cr>

" Google's JSLint
au BufNewFile,BufRead *.js set makeprg=gjslint\ %
au BufNewFile,BufRead *.js set errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyle%s,%-Gscript\ can\ %s,%-G

" Easier linewise reselection
map <leader>v V`]

" HTML tag closing
inoremap <leader>k <Space><BS><Esc>:call InsertCloseTag()<cr>a


" Diff
nmap <leader>d :!hg diff %<cr>

" Edit .vimrc
nmap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Easy filetype switching
nnoremap _dt :set ft=htmldjango.html<CR>
nnoremap _dj :set ft=python.django<CR>


" Stop it, hash key
inoremap # X<BS>#

if has('gui_running')
    colorscheme molokai
    set background=dark

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    if has("gui_macvim")
        macmenu &File.New\ Tab key=<nop>
    end

    let g:sparkupExecuteMapping = '<C-e>'

    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

" Ctags path setting for taglist plugin
let Tlist_WinWidth = 50
map <F2> :TlistToggle<cr>

" Switch between relative and absolute line numbers
function! g:ToggleNuMode() 
    if(&rnu == 1) 
        set nu 
    else 
        set rnu 
    endif 
endfunc 

nnoremap <leader>l :call g:ToggleNuMode()<cr> 

set autochdir


if has('win32')
	set guifont=Consolas:h10
	
   	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 
	
    	let Tlist_Ctags_Cmd="D:/Programi/Vim/ctags.exe"
	
	set backupdir=~/_vim/tmp/backup// " backups
	set directory=~/_vim/tmp/swap//   " swap files
endif
if has('unix')
	set guifont=Menlo:h12
	
	let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
	
	set backupdir=~/.vim/tmp/backup// " backups
	set directory=~/.vim/tmp/swap//   " swap files
	
	" Fuck you, help key.
	set fuoptions=maxvert,maxhorz
	inoremap <F11> <ESC>:set invfullscreen<CR>a
	nnoremap <F11> :set invfullscreen<CR>
	vnoremap <F11> :set invfullscreen<CR>
	
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	let g:syntastic_enable_signs=1
	let g:syntastic_auto_loc_list=1
endif
