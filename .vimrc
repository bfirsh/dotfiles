" Inspiration:
" http://github.com/askedrelic/homedir/blob/master/.vimrc
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

" where to put backup files
set backupdir=~/.vim/backup
" directory to place swap files in
"set directory=~/.vim/tmp

"make backspace work
set backspace=indent,eol,start
set showmatch
" have % bounce between angled brackets, as well as other kinds:
set matchpairs+=<:>
set comments=s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-

" allow you to have multiple files open and change between them without saving
set hidden


set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set wildchar=<TAB>
set ttyfast
set ruler
set laststatus=2
set pastetoggle=<F2>

if version >= 703
    set relativenumber
    set undofile
else
    set number
endif

let mapleader = ","

if has("gui_running")
    " invisible characters
    set list
    set listchars=tab:▸\ ,eol:¬
endif


" Tabs **********************************************************************

" when at 3 spaces, and I hit > ... go to 4, not 5
set shiftround 

function! Indent_tabs()
    setl softtabstop=4
    setl shiftwidth=4
    setl tabstop=4
    setl noexpandtab
endfunction

function! Indent_4_spaces()
    setl expandtab
    setl autoindent
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
endfunction

function! Indent_2_spaces()
    setl expandtab
    setl autoindent
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
endfunction

set expandtab autoindent shiftwidth=4 tabstop=4 softtabstop=4
au FileType html call Indent_2_spaces()
au FileType htmldjango call Indent_2_spaces()
au FileType ruby call Indent_2_spaces()

" Spell checking for latex files
au FileType tex set spl=en_gb spell

" Searching *******************************************************************
" don't use vim's crazy regex
nnoremap / /\v
vnoremap / /\v

" highlight search
set hlsearch
" case inferred by default
set infercase 
" make searches case-insensitive
set ignorecase
"unless they contain upper-case letters:
set smartcase
" show the `best match so far' as search strings are typed:
set incsearch
" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" ,<space> to get rid of search highlighting
nnoremap <leader><space> :noh<cr>
" tab to match bracket pairs
nnoremap <tab> %
vnoremap <tab> %


" Colors **********************************************************************
colorscheme twilight
syntax on
set guioptions-=T
set guioptions-=m


" Line wrapping
" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions=cqr1
set textwidth=79

" -----------------------------------------------------------------------------
" | Aliases and custom key functions                                          |
" -----------------------------------------------------------------------------
" Professor VIM says '87% of users prefer jj over esc', jj abrams strongly disagrees
imap jj <Esc>

" sudo save!
cmap w!! %!sudo tee > /dev/null %

nnoremap j gj
nnoremap k gk

" open a new split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" ctrl-hjkl for moving around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif


