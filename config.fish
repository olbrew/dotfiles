# Remove fish default greeting
set fish_greeting

## Vi keybindings
fish_vi_key_bindings

## Environment variables
# Editor
set -x EDITOR 'kak'
# Compilation flags
set -x ARCHFLAGS '-arch x86_64'
# Prevent ._* files from being written
set -x COPYFILE_DISABLE 'true'
# no insecure redirect for homebrew
set -x HOMEBREW_NO_INSECURE_REDIRECT 'true'
# disable homebrew analytics
set -x HOMEBREW_NO_ANALYTICS 1
