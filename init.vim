""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vim configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [Vim-Plug](https://github.com/junegunn/vim-plug)
call plug#begin()

Plug 'Valloric/YouCompleteMe'                           " Autocomplete support
Plug 'benekastah/neomake'                               " Asynchronous make & syntax checker
Plug 'Chiel92/vim-autoformat'                           " Autoformatting
Plug 'tpope/vim-fugitive'                               " Git wrapper
Plug 'LaTeX-Box-Team/LaTeX-Box'                         " LateX support
Plug 'tpope/vim-obsession'                              " Vim session management
Plug 'junegunn/goyo.vim'                                " Distraction free mode
Plug 'SirVer/ultisnips'                                 " Snippets support
Plug 'honza/vim-snippets'                               " Built-in snippet defaults
Plug 'junegunn/vim-easy-align'                          " Align things
Plug 'chriskempson/base16-vim'                          " Base16 Solarized colorscheme
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' " Fancy statusline
Plug 'sjl/gundo.vim'                                    " Visual undo-tree
Plug 'ryanss/vim-hackernews', { 'on': 'HackerNews' }    " HackerNews in vim
Plug 'Raimondi/delimitMate'                             " Auto match parentheses,...
Plug 'junegunn/fzf.vim'                                 " FZF integration
Plug 'christoomey/vim-tmux-navigator'                   " Consistent vim, tmux window mappings
Plug 'airblade/vim-gitgutter'                           " Git diff in gutter
Plug 'Lokaltog/vim-easymotion'                          " Faster vim motions
Plug 'critiqjo/lldb.nvim'                               " LLDB integration

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable True Color
set termguicolors

" Solarized colorscheme
colorscheme base16-solarized-dark
" Access colors present in 256 colorspace
let base16colorspace=256

" Set background for colors
set background=dark

" Disable swap files
set noswapfile

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

" Set makeprg to search for makefiles one directory up if one exists
let &makeprg = '[[ -f Makefile ]] && make || make -C ..'

" File explorer tree mode
let g:netrw_liststyle=3
let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.swp$'

" Command for closing buffer without corresponding window
command! Bd bp | bd#

" Autoformat buffer on write
au BufWrite * :Autoformat

" Fast code searching with rg - RipGrepif executable('rg')
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Persistent undo
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000

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

" Search and replace on all buffers
function! SeR(search, replace)
    bufdo %s/a:search/a:replace/ge | update
endfunction

" Update Ctags if a tags file has been found
function! UpdateCTags()
    :! ctags -R --exclude=.git --exclude=doc --languages=-javascript,sql --append -f ../.tags
endfunction
set tags=.tags;..;../..

" Helper functions to allow UltiSnips to work with YCM and <tab>s
" Enable tabbing through list of results
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" Expand snippet or return
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
        return ''
    else
        return "\<return>"
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Maps                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map Space to leader
map <Space> <Leader>

" Workaround for easymotion
map <space><space> <leader><leader>

" Disable arrow key navigation
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Faster buffer switching
nnoremap J :bprevious<CR>
nnoremap K :bnext<CR>

" Better vertical movement with linewrappings
"nnoremap j gj
"nnoremap k gk

" Nvim terminal
if has('nvim')
    nnoremap <Leader>t :vsp term://fish<CR>
    tnoremap <Esc> <C-\><C-n>
    tnoremap jj <C-\><C-n>
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif

" Remap escape
inoremap jj <ESC>

" Unmap Ex mode
map Q <Nop>

" Y yanks to end of line
noremap Y y$

" Set pastetoggle
set pastetoggle=<Leader>p

" Disable search highlight after searching
nnoremap <c-L> :noh<return>

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

" Bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Add FZF to vim runtimepath
set rtp+=/usr/local/opt/fzf

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Shortcuts                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>g :YcmCompleter GoTo<CR>
autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
nnoremap <Leader>x :YcmCompleter FixIt<CR>
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>y :YcmDiags<CR>
nnoremap <Leader>r :so $MYVIMRC<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>w :Obsess .session.vim<CR>
nnoremap <Leader>m :Neomake!<CR>
nnoremap <Leader>n :Neomake<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Plugin config                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe global C++ compilation flags
let g:ycm_global_ycm_extra_conf='~/.config/nvim/cfg/ycm_extra_conf.py'

" Run Neomake linter when opening or saving buffers
autocmd BufWritePost,BufEnter * Neomake

" Don't fall back to the vim indent file for Autformat
let g:autoformat_autoindent=0

" FZF
let $FZF_DEFAULT_COMMAND = 'rg --vimgrep ""'
let g:fzf_layout={ 'down': '20%' }

" Ultisnips
let g:UltiSnipsExpandTrigger       ="<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
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

"" Temporary workarounds
" Allow Neovim to move left on <C-h>
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
