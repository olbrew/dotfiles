""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Vim configuration                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Plugins                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically install vim-plug when opening init.vim
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter init.vim PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter init.vim if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'neovim/nvim-lspconfig'                        " Neovim LanguageServerProtocol configurations
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'          " Indentation guides
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Install latest version of FZF, if not found
Plug 'junegunn/fzf.vim'                             " FZF Git integration
"Plug 'github/copilot.vim'                           " Github Copilot (Still in beta)
Plug 'sheerun/vim-polyglot'                         " Language pack
Plug 'tpope/vim-repeat'                             " Repeat with . for plugins
Plug 'tpope/vim-fugitive'                           " Git wrapper
Plug 'tpope/vim-vinegar'                            " Netrw improved
Plug 'tpope/vim-surround'                           " Quoting/parenthesizing made simple
Plug 'junegunn/vim-easy-align'                      " Align things
Plug 'nathanaelkane/vim-indent-guides'              " Indentation guides
Plug 'bkad/CamelCaseMotion'                         " Vim motions for camelcase and underscore notation
Plug 'rmehri01/onenord.nvim'                        " OneNord color scheme
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
call plug#end()

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
colorscheme onenord

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
set timeoutlen=500

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
set clipboard+=unnamedplus

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
if has("mac")
    autocmd VimEnter * if argc() == 0 | edit ~/Library/Mobile Documents/iCloud~co~fluder~fsnotes/Documents/scratch.md | endif
elseif has("unix")
    autocmd VimEnter * if argc() == 0 | edit ~/scratch.md | endif
endif

" Execute current Python script
autocmd Filetype python nnoremap <buffer> <leader>p :w<CR>:split term://python %<CR>

" Highlight yanked region
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Functions                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically remove trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * call TrimWhiteSpace()

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
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>s :Rg<CR>
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>z 1z=
nnoremap <Leader>gs :Git<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Plugin config                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Set Python host
if has("mac")
    let g:python3_host_prog                       = '/usr/local/bin/python3'
elseif has("unix")
    let g:python3_host_prog                       = '/usr/bin/python3'
endif

" Allow JSX in normal JS files
let g:jsx_ext_required                            = 0


" Indent blankline
lua <<EOF
--vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Language server setup                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('lspconfig').pylsp.setup{}
lua require('lspconfig').html.setup{}

