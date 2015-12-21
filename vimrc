""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vim configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [Vim-Plug](https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/bundle')

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' } " Autocomplete support
Plug 'Chiel92/vim-autoformat'                           " Autoformatting
Plug 'tpope/vim-fugitive'                               " Git wrapper
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }       " LateX support
Plug 'tpope/vim-obsession'                              " Vim session management
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }              " Distraction free mode
Plug 'SirVer/ultisnips'                                 " Snippets support
Plug 'honza/vim-snippets'                               " Built-in snippet defaults
Plug 'junegunn/vim-easy-align'                          " Align things
Plug 'tpope/vim-dispatch'                               " Asynchronous compiling
Plug 'chriskempson/base16-vim'                          " Base16 Solarized colorscheme
Plug 'bling/vim-airline'                                " Fancy statusline
Plug 'sjl/gundo.vim'                                    " Visual undo-tree
Plug 'scrooloose/syntastic'                             " Syntax checker
Plug 'ryanss/vim-hackernews', { 'on': 'HackerNews' }    " HackerNews in vim
Plug 'Raimondi/delimitMate'                             " Auto match parentheses,...
Plug 'rking/ag.vim'                                     " Ag integration
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                                 " fzf integration
Plug 'christoomey/vim-tmux-navigator'                   " Consistent vim, tmux window mappings
Plug 'airblade/vim-gitgutter'                           " Git diff in gutter
Plug 'benekastah/neomake'                               " Asynchronous make & syntax checker
Plug 'Lokaltog/vim-easymotion'                          " Faster vim motions

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

" Enable filetype detection & indenting
filetype plugin indent on

" Enable syntax highlighting
syntax on

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
set textwidth=80
let &showbreak='↪  '
set linebreak

" Enable mouse support
if has('mouse')
    set mouse=a
endif

" Save file when vim loses focus or change to another buffer
autocmd BufLeave,FocusLost * :wa

" Recognize md files as markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Enable spell checking for prose
autocmd FileType tex setlocal spell spelllang=en,nl
autocmd FileType text setlocal spell spelllang=en,nl
autocmd FileType markdown setlocal spell spelllang=en,nl
autocmd FileType gitcommit setlocal spell spelllang=en,nl

" Add spelling suggestions to autocomplete
set complete+=kspell

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
au BufWrite * :Autoformat

" Fast code searching with Ag - The Silver Surfer
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Map leader to 'space'
let mapleader=" "

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
autocmd BufWritePre * call TrimWhiteSpace()

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
"nnoremap j gj
"nnoremap k gk

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
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Switch ':' with ';' for faster commands (without <S>)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Bind K to grep word under cursor
"nnoremap S :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Bind \ (backward slash) to grep shortcut
if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
nnoremap \ :Ag<SPACE>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Shortcuts                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>y :YcmDiags<CR>
nnoremap <Leader>r :so $MYVIMRC<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>w :Obsess .session.vim<CR>
nnoremap <Leader>m :Make<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Plugin config                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe global C++ compilation flags
let g:ycm_global_ycm_extra_conf = '~/.vim/cfg/ycm_extra_conf.py'

" Don't fall back to the vim indent file for Autformat
let g:autoformat_autoindent = 0

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
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
