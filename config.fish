# Remove fish default greeting
set --erase fish_greeting

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'agnoster'
Plugin 'theme'

# Extra plugins
Plugin 'brew'
Plugin 'balias'
Plugin 'jump'

# Vi keybindings
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

## Load functions
# Load aliases
aliases
