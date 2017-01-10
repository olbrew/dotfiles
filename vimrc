""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vim configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype detection & indenting
filetype plugin indent on

" Enable syntax highlighting
syntax on

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

" Decrease timeout for key sequences
set ttimeout
set ttimeoutlen=100

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

" Fast code searching with rg - Rip Grep
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Functions                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically remove trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * call TrimWhiteSpace()

" Search and replace on all buffers
function! SeR(search, replace)
    bufdo %s/a:search/a:replace/ge | update
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Maps                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map Space to leader
map <Space> <Leader>

" Faster buffer switching
nnoremap J :bprevious<CR>
nnoremap K :bnext<CR>

" Better vertical movement with linewrappings
"nnoremap j gj
"nnoremap k gk

" Remap escape
inoremap jj <ESC>

" Unmap Ex mode
map Q <Nop>

" Y yanks to end of line
map Y y$

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

" Stamp words - Change word with (paste) value from register
nnoremap S diw"0P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Shortcuts                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>r :so $MYVIMRC<CR>
