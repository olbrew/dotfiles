""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vim configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use included defaults
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set background for colors
set background=dark

" Set true colour support
set termguicolors

" Don't lose undo history when changing buffers
set hidden

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

" Visual warnings instead of audio
set visualbell

" Reload file after external changes
set autoread
set autowrite

" Search settings
set ignorecase
set smartcase
set showmatch

" Textwrapping
set wrap
set textwidth=80
let &showbreak='↪  '
set linebreak

" Save file when vim loses focus or change to another buffer
autocmd BufLeave,FocusLost * silent! wall

" System clipboard functionality
set clipboard+=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Functions                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically remove trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * call TrimWhiteSpace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Maps                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map Space to leader
map <Space> <Leader>

" Remap escape
inoremap jj <ESC>

" Reload config in vim
nnoremap <Leader>r :so $MYVIMRC<CR>

" Switch ':' with ';' for faster commands (without <S>)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Faster buffer switching
nnoremap J :bprevious<CR>
nnoremap K :bnext<CR>

" Better vertical movement with linewrappings
nnoremap j gj
nnoremap k gk

" Y yanks to end of line
map Y y$

" Enter newlines without entering insert mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Scroll faster through command history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Stamp words - Change word with (paste) value from register
nnoremap S diw"0P
