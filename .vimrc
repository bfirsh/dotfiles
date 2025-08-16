" Inspiration:
" http://github.com/askedrelic/homedir/blob/master/.vimrc
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" https://github.com/skwp/dotfiles/blob/master/vimrc

" This must be first, because it changes other options as a side effect.
set nocompatible

" Disable youcompleteme error
if v:version < 703 || !has( 'patch584' )
    let g:loaded_youcompleteme = 1
endif

" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" {{{ General

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
set foldmethod=marker
set wildignore+=*.o,*~,*.pyc,.git,.git-heroku,.hg,.svn,.sass-cache,node_modules

if version >= 703
    set relativenumber
else
    set number
endif

let mapleader = ","

if has("gui_running")
    " invisible characters
    set list
    set listchars=tab:▸\ ,eol:¬
endif

" No swap files.
set noswapfile
set nobackup
set nowb

" Keep undo history across sessions, by storing in file.
" Only works in MacVim (gui) mode.

set noundofile
if has('gui_running')
  set undodir=~/.vim/backups
  set undofile
endif

" }}}
" {{{ Filetypes

" HTML and HTMLDjango
au BufNewFile,BufRead *.html setlocal filetype=htmldjango
au BufNewFile,BufRead *.html setlocal foldmethod=manual
au BufNewFile,BufRead *.html setlocal textwidth=0
au BufNewFile,BufRead urls.py setlocal nowrap

" Use <localleader>f to fold the current tag.
au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

" Use Shift-Return to turn this:
"     <tag>|</tag>
"
" into this:
"     <tag>
"         |
"     </tag>
au BufNewFile,BufRead *.html inoremap <buffer> <s-cr> <cr><esc>kA<cr>
au BufNewFile,BufRead *.html nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

" Django tags
au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

" Django variables
au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>

" Spell checking for latex files
au FileType tex set spl=en_gb spell

au BufNewFile,BufRead riemann.config set filetype=clojure
au BufNewFile,BufRead *.md set filetype=markdown

" }}}
" {{{ Tabs

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
au FileType coffee call Indent_2_spaces()
au FileType eruby call Indent_2_spaces()
au FileType go call Indent_tabs()
au FileType html call Indent_2_spaces()
au FileType htmldjango call Indent_2_spaces()
au FileType handlebars call Indent_2_spaces()
au FileType javascript call Indent_2_spaces()
au FileType python call Indent_4_spaces()
au FileType ruby call Indent_2_spaces()
au FileType sass call Indent_2_spaces()
au FileType scss.css call Indent_2_spaces()

" }}}
" {{{ Searching

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

" }}}
" {{{ Colors
set t_Co=256
set background=dark
colorscheme solarized
syntax on
set guioptions-=T
set guioptions-=m


" {{{ Line wrapping
" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions=qrn1
set textwidth=79

function! No_Line_Breaks()
    " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
    set wrap
    set linebreak
    set nolist  " list disables linebreak
    set textwidth=0
    set wrapmargin=0
endfunction

au FileType markdown,tex,rst call No_Line_Breaks()


au FileType gitcommit setlocal formatoptions=tan1w


" }}}

" }}}
" {{{ Aliases

" Professor VIM says '87% of users prefer jj over esc', jj abrams strongly disagrees
imap jj <Esc>

" sudo save!
cmap w!! %!sudo tee > /dev/null %

nnoremap j gj
nnoremap k gk

" open a new split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" cmd-hjkl for moving around splits
nnoremap <D-h> <C-w>h
nnoremap <D-j> <C-w>j
nnoremap <D-k> <C-w>k
nnoremap <D-l> <C-w>l

" Change inside quotes with Cmd-" and Cmd-'
nnoremap <D-'> ci'
nnoremap <D-"> ci"

" Don't have to use Shift to get into command mode, just hit semicolon
nnoremap ; :

"Go to last edit location with ,.
nnoremap ,. '.


" }}}


" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Takes forever
let g:syntastic_disabled_filetypes = ['sass', 'python']


" Fix colours in sign column
highlight clear SignColumn

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_lazy_update = 150

let g:airline_powerline_fonts = 0


