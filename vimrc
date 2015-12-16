""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vim configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

" Remove vim/vi compatibility
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [Vim-Plug](https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/bundle')

Plug 'Valloric/YouCompleteMe'                           " Autocomplete support
Plug 'Chiel92/vim-autoformat'                           " Autoformatting
Plug 'tpope/vim-fugitive'                               " Git wrapper
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }       " LateX support
Plug 'wincent/command-t'                                " Fuzzy file finder
Plug 'tpope/vim-surround'                               " Vim features for brackets, quotes, ...
Plug 'tpope/vim-obsession'                              " Saves and restores vim sessions
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }              " Distraction free mode
Plug 'SirVer/ultisnips'                                 " Snippets support
Plug 'honza/vim-snippets'                               " Built-in snippet defaults
Plug 'godlygeek/tabular'                                " Align things
Plug 'tpope/vim-dispatch'                               " Asynchronous compiling
Plug 'chriskempson/base16-vim'                          " Base16 Solarized colorscheme
Plug 'bling/vim-airline'                                " Fancy statusline
Plug 'sjl/gundo.vim'                                    " Visual undo-tree
Plug 'scrooloose/syntastic'                             " Syntax checking for non C-family languages
Plug 'ryanss/vim-hackernews', { 'on': 'HackerNews' }    " HackerNews plugin
Plug 'Raimondi/delimitMate'                             " Automatically matching parentheses, ...
Plug 'rking/ag.vim'                                     " Ag-vim integration
Plug 'christoomey/vim-tmux-navigator'                   " Consistent vim, tmux window mappings
Plug 'airblade/vim-gitgutter'                           " Show git diff sings in gutter
"Plug 'Lokaltog/vim-easymotion'                         " Faster vim motions

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype detection & indenting
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Set standard encoding to utf-8
set encoding=utf-8

" Solarized colorscheme
colorscheme base16-solarized

" Set background for colors
set background=dark

" Don't lose undo history when changing buffers
set hidden

" Bash-like file completion
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*.d

" Start scrolling when 5 lines away from margin
set scrolloff=5

" Tab space settings
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Show line numbers
set number
set relativenumber
set ruler

" Always show status line
set laststatus=2

" Allow backspace in insert
set backspace=indent,eol,start

" Show extra info about commands
set showcmd
set showmode

" Visual warnings instead of audio
set visualbell

" Reload file after external changes
set autoread
set autowrite

" Search settings
set incsearch
set ignorecase
set smartcase
set showmatch

" Textwrapping
set wrap
"set textwidth=80
"set showbreak=↪

" Enable mouse support
if has('mouse')
    set mouse=a
endif

" Save file when vim loses focus or change to another buffer
autocmd BufLeave,FocusLost * :wa

" Recognize md files as markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Enable spell checking for prose
autocmd FileType tex setlocal spell spelllang=en_us,nl
autocmd FileType markdown setlocal spell spelllang=en_us,nl

" System clipboard functionality
set clipboard+=unnamed

" Disable scratch preview window on autocomplete
set completeopt-=preview

" File explorer tree mode
let g:netrw_liststyle=3
let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.swp$'

" Command for closing buffer without corresponding window
command! Bd bp | bd#

" Autoformat buffer on write
au BufWrite *.cpp,*.h,*.cc,*.hh :Autoformat

" Map leader to 'space'
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Functions                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile LaTeX docs on save
" Dependency: LatexBox plugin
function! CompileLatex()
    :Latexmk
    :LatexmkClean
endfunction
autocmd BufWritePost *.tex call CompileLatex()

" Automatically remove trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
" And execute it automatically on buffer write
autocmd BufWritePre * call TrimWhiteSpace()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

" Fast code searching with Ag - The Silver Surfer
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Remaps                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable arrow key navigation
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Better vertical movement with linewrappings
nnoremap j gj
nnoremap k gk

" Remap escape
inoremap jj <ESC>

" Unmap Ex mode
map Q <Nop>

" Y yanks to end of line
noremap Y y$

" Set pastetoggle
set pastetoggle=<Leader>p

" Save files for which you didn't have permission
cnoremap w!! w !sudo tee % >/dev/null

" Enter newlines without entering insert mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Scroll faster through command history
"cnoremap <c-j> <down>
"cnoremap <c-k> <up>

" Switch ':' with ';' for faster commands (without <S>)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Bind K to grep word under cursor
nnoremap S :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Shortcuts                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>y :YcmDiags<CR>
nnoremap <Leader>r :so $MYVIMRC<CR>
nnoremap <Leader>t :CommandT<CR>
nnoremap <Leader>b :CommandTBuffer<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>w :Obsess .session.vim<CR>
nnoremap <Leader>m :Make<CR>
nnoremap <Leader>c :cw<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Plugin config                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe global C++ compilation flags
let g:ycm_global_ycm_extra_conf = '~/.vim/cfg/ycm_extra_conf.py'

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=["cfg"]

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#buffer_min_count=2
let g:airline_powerline_fonts=1

" LatexBox
let g:LatexBox_quickfix=3
let g:LatexBox_autojump=1
let g:LatexBox_show_warnings=0

" CommandT
let g:CommandTFileScanner="git"
let g:CommandTTraverseSCM="pwd"
