""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vim configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove vim/vi compatibility for Vundle init
set nocompatible

" Vundle start
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'Valloric/YouCompleteMe'           " Autocomplete support
Plugin 'Chiel92/vim-autoformat'           " autoformatting
Plugin 'LaTeX-Box-Team/LaTeX-Box'         " LateX support
Plugin 'wincent/command-t'                " Fuzzy file finder
Plugin 'tpope/vim-surround'               " Vim features for brackets, quotes, ...
Plugin 'tpope/vim-obsession'              " Saves and restores vim sessions
Plugin 'junegunn/goyo.vim'                " Distraction free mode
Plugin 'SirVer/ultisnips'                 " Snippets support
Plugin 'honza/vim-snippets'               " Built-in snippet defaults
Plugin 'godlygeek/tabular'                " Align things
Plugin 'tpope/vim-dispatch'               " Asynchronous compiling
Plugin 'bling/vim-airline'                " Fancy statusline
Plugin 'altercation/vim-colors-solarized' " Solarized colorscheme
Plugin 'sjl/gundo.vim'                    " Visual undo-tree
Plugin 'Lokaltog/vim-easymotion'          " Faster vim motions
Plugin 'scrooloose/syntastic'             " Syntax checking for non C-family languages
"Plugin 'suan/vim-instant-markdown' " Instant  markdown preview

" Vundle end
call vundle#end()

" Enable filetype detection & indenting
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Set standard encoding to utf-8
set encoding=utf-8

" Solarized colorscheme
colorscheme solarized

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
"set showbreak=↪

" Set background for colors
set background=dark

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
autocmd BufWritePre * call TrimWhiteSpace()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Remaps                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable arrow key navigation
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Remap escape
inoremap jj <ESC>

" Unmap Ex mode
map Q <Nop>

" Set pastetoggle
set pastetoggle=<Leader>p

" Save files for which you didn't have permission
cnoremap w!! w !sudo tee % >/dev/null

" Enter newlines without entering insert mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Scroll faster through command history
cnoremap <c-j> <down>
cnoremap <c-k> <up>

" Switch ':' with ';' for faster commands (without <S>)
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Shortcuts                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>c 1z=
nnoremap <Leader>f :Autoformat<CR><CR>
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>y :YcmDiags<CR>
nnoremap <Leader>r :so $MYVIMRC<CR>
nnoremap <Leader>t :CommandT<CR>
nnoremap <Leader>b :CommandTBuffer<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>w :Obsession .session.vim<CR>

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

" Autoformat
let g:formatprg_cpp = "astyle"
let g:formatprg_args_expr_cpp = '"--mode=c --style=ansi -Y -N --max-code-length=80 --break-after-logical -k1 -pcUH".(&expandtab ? "s".&shiftwidth : "t")'

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#buffer_min_count=2
let g:airline_powerline_fonts=1

" EasymotionG
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" LatexBox
let g:LatexBox_quickfix=3
let g:LatexBox_autojump=1
let g:LatexBox_show_warnings=0

" CommandT
let g:CommandTFileScanner="find"
let g:CommandTTraverseSCM="pwd"
