# Place in order of importance and fastest loading first
# bashrc is a script which gets executed every time bash is loaded
# Vi-mode:
set -o vi

# Add some colour
source "`brew --prefix`/etc/grc.bashrc"
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Path:
export PATH="/usr/local/sbin":${PATH}

# Load bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load bash functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi


# Display system info on startup
archey -c

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Prevent ._* files from being written
export COPYFILE_DISABLE=true

# Homebrew caskroom
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/caskroom"

# todo.txt options:
complete -F _todo t
export TODOTXT_DEFAULT_ACTION=ls

# Ruby rbenv config
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
