# Remove fish default greeting
set --erase fish_greeting

# Vi keybindings
set fish_key_bindings fish_user_key_bindings

## Environment variables
# Editor
set -x EDITOR 'vim'
# Compilation flags
set -x ARCHFLAGS '-arch x86_64'
# Prevent ._* files from being written
set -x COPYFILE_DISABLE 'true'
# Homebrew caskroom
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --caskroom=/usr/local/caskroom'
# Let fzf use `ag` instead of `find`
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
# todo.txt options:
set -x TODOTXT_DEFAULT_ACTION 'ls'
# no insecure redirect for homebrew
set -x HOMEBREW_NO_INSECURE_REDIRECT 'true'
# gopath
set -x GOPATH $HOME/Code/go

## Custom jump loading
set -gx MARKPATH $HOME/.marks
command mkdir -p $MARKPATH

complete -c jump -f -a '(ls ~/.marks)'
complete -c unmark -f -a '(ls ~/.marks)'
