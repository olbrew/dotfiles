# Remove fish default greeting
set --erase fish_greeting

## Vi keybindings
fish_vi_key_bindings
# Remove builtin vi mode indicator in favour of custom theme
function fish_mode_prompt
end function

## Environment variables
# Editor
set -x EDITOR 'vim'
# Compilation flags
set -x ARCHFLAGS '-arch x86_64'
# Prevent ._* files from being written
set -x COPYFILE_DISABLE 'true'
# Homebrew caskroom
set -x HOMEBREW_CASK_OPTS '--caskroom=/usr/local/caskroom'
# Let fzf use `ag` instead of `find`
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
# todo.txt options:
set -x TODOTXT_DEFAULT_ACTION 'ls'
# no insecure redirect for homebrew
set -x HOMEBREW_NO_INSECURE_REDIRECT 'true'
# disable homebrew analytics
set -x HOMEBREW_NO_ANALYTICS 1
# gopath
set -x GOPATH $HOME/Developer/go
