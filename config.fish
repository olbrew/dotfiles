# Remove fish default greeting
set --erase fish_greeting

# Vi keybindings
fish_vi_mode
set fish_key_bindings fish_user_key_bindings
set fish_bind_mode insert

## Environment variables
# Editor
set -x EDITOR 'vim'
# Compilation flags
set -x ARCHFLAGS '-arch x86_64'
# Prevent ._* files from being written
set -x COPYFILE_DISABLE 'true'
# Homebrew caskroom
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --caskroom=/usr/local/caskroom'
# todo.txt options:
set -x TODOTXT_DEFAULT_ACTION 'ls'

## Custom jump loading
set -gx MARKPATH $HOME/.marks
command mkdir -p $MARKPATH

complete -c jump -f -a '(ls ~/.marks)'
complete -c unmark -f -a '(ls ~/.marks)'
