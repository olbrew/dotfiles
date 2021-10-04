""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Vim configuration                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Plugins                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
"Plug 'zxqfl/tabnine-vim'                            " Tabnine autocompletion
Plug 'dense-analysis/ale'                           " Syntax checker and linter
Plug 'psf/black', { 'branch': 'stable' }            " Python formatter (no ALE support yet)
Plug 'Chiel92/vim-autoformat'                       " Autoformatter
Plug 'sheerun/vim-polyglot'                         " Language pack
Plug 'tpope/vim-repeat'                             " Repeat with . for plugins
Plug 'tpope/vim-fugitive'                           " Git wrapper
Plug 'tpope/vim-vinegar'                            " Netrw improved
Plug 'tpope/vim-surround'                           " Quoting/parenthesizing made simple
Plug 'junegunn/vim-easy-align'                      " Align things
Plug 'nathanaelkane/vim-indent-guides'              " Indentation guides
Plug 'bkad/CamelCaseMotion'                         " Vim motions for camelcase and underscore notation
Plug 'joshdick/onedark.vim'                         " Onedark color scheme
Plug 'Raimondi/delimitMate'                         " Auto match parentheses,...
Plug 'christoomey/vim-tmux-navigator'               " Consistent vim-tmux window mappings
Plug 'airblade/vim-gitgutter'                       " Git diff in gutter
Plug 'brooth/far.vim'                               " Project-wide find and Replace
Plug 'easymotion/vim-easymotion'                    " Faster vim motions
Plug 'Valloric/ListToggle'                          " Quickfix and locationlist toggle
Plug 'kassio/neoterm'                               " Wrapper for neovim terminal
Plug 'mbbill/undotree'                              " Visual undo-tree
Plug 'junegunn/goyo.vim'                            " Distraction free mode
Plug 'dansomething/vim-hackernews'                  " HackerNews in vim
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " FZF integration
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " Built-in snippet defaults
call plug#end()

" Automatically install missing plugins when opening init.vim
autocmd VimEnter init.vim
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        General                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader
let mapleader      = ' '
let maplocalleader = ' '

" Enable True Color
" Terminal.app doesn't yet support True color
set termguicolors

" Theme
colorscheme onedark

" Set background for colors
set background=dark

" Disable swap files
set noswapfile

" Don't lose undo history when changing buffers
set hidden

" Bash-like file completion
set wildmode=list:longest,full
let &wildignore = join(map(split(substitute(substitute(
            \ netrw_gitignore#Hide(), '\.\*', '*', 'g'), '\\.', '.', 'g'), ','),
            \ "v:val.','.v:val.'/'"), ',')

" Better scrolling behaviour
set scrolloff=5

" Tab space settings
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Enable mouse support
set mouse=a

" Decrease timeout for key sequences
set ttimeout
set ttimeoutlen=100

" Show line numbers
set number
set relativenumber

" Show extra info about commands
set showmode

" Reload file after external changes
set autowrite

" Search settings
set ignorecase
set smartcase
set showmatch

" Textwrapping
set wrap
"set textwidth=80
let &showbreak='↪  '
set linebreak
set breakindent

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Text formatting - Don't set two spaces after the end of a sentence
set nojoinspaces

" Save file when vim loses focus or change to another buffer
autocmd BufLeave,FocusLost * silent! wall

" Recognize some html as templates becuase of issues with linters
"autocmd BufNewFile,BufRead *.html set filetype=htmldjango
autocmd BufNewFile,BufRead *.twig set filetype=htmldjango

" Recognize partial files as full-fledged tex files
let g:tex_flavor = 'latex'

" Recognize HTML in PHP code
let php_htmlInStrings = 1

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

" Command for closing buffer without corresponding window
command! Bd bp | bd#

" Fast code searching with rg - RipGrep
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case
endif

" Persistent undo
set undofile

" Automatically edit scratch file when not editing another file
autocmd VimEnter * if argc() == 0 | edit ~/Library/Mobile Documents/iCloud~co~fluder~fsnotes/Documents/scratch.md | endif

" Execute current Python script
autocmd Filetype python nnoremap <buffer> <leader>p :w<CR>:split term://python %<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Functions                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically remove trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * call TrimWhiteSpace()

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
    endif
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Maps                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap escape
inoremap jj <ESC>

" switch ':' with ';' for faster commands (without <s>)
"nnoremap ; :
"nnoremap : ;
"vnoremap ; :
"vnoremap : ;

" Unmap Ex mode
map Q <Nop>

" Y yanks to end of line
noremap Y y$

" Workaround for easymotion
map <space><space> <leader><leader>

" Faster buffer switching
nnoremap J :bprevious<CR>
nnoremap K :bnext<CR>

" Enter newlines without entering insert mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Scroll faster through command history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Stamp words - Change word with (paste) value from register
nnoremap S diw"0P

" Bind R to grep word under cursor
nnoremap R :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Nvim terminal
autocmd BufWinEnter,WinEnter term://* startinsert
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Shortcuts                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>r :source $MYVIMRC<CR>
nnoremap <Leader>v :sp $MYVIMRC<CR>
nnoremap <Leader>t :sp term://fish<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>x :YcmCompleter FixIt<CR>
nnoremap <Leader>y :YcmDiags<CR>
nnoremap <Leader>m :ALEFix<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>s :RipGrep<CR>
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>z 1z=
nnoremap <leader>w :let b:ale_fix_on_save=0<CR>:w<CR>
nnoremap <Leader>gs :Gstatus<CR>
noremap <Leader>af :Autoformat<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Plugin config                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM replacement for Ctags in C files
autocmd FileType c,cpp nnoremap <buffer> <silent> <C-]>: YcmCompleter GoTo<cr>

" Format Python code with Black
"autocmd BufWritePre *.py execute ':Black'

" Ale linter, fixer and formatter
let g:ale_fixers = {
            \'*': ['remove_trailing_lines', 'trim_whitespace'],
            \'javascript': ['prettier'],
            \'html': ['prettier'],
            \'css': ['prettier'],
            \'markdown': ['prettier', 'proselint'],
            \'text': ['proselint'],
            \'tex': ['proselint'],
            \'gitcommit': ['proselint'],
            \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0

" Enabel CamelCaseMotion with default mappings
let g:camelcasemotion_key = '<leader>'
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Place vim sessions in neovim directory
let g:gitsessions_dir                             = '~/.config/nvim/sessions'

" File explorer tree mode
let g:netrw_liststyle                             = 3
let g:netrw_list_hide                             = netrw_gitignore#Hide()
let g:netrw_dirhistmax                            = 0

" Ultisnips
let g:UltiSnipsExpandTrigger                      = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger                 = "<tab>"
let g:UltiSnipsJumpBackwardTrigger                = "<s-tab>"
let g:UltiSnipsSnippetDirectories                 = ["cfg"]


" Allow JSX in normal JS files
let g:jsx_ext_required                            = 0

" Ultisnips change expandtrigger to not conflict with YCM
let g:UltiSnipsExpandTrigger                      = "<c-j>"
