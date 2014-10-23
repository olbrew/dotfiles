# Temp shortcuts
alias ini='find . -type f -name "*.ini" -print  -exec ../../src/engine {} \;'
alias wkserver='vagrant ssh -- python /vagrant/src/manage.py runserver 0.0.0.0:8000'

# Shell 
alias l='ls -GFh'
alias ls='ls -lGFh'
alias ll='ls -lGFha'
alias ..='cd ../'
alias ...='cd ../../'
alias j='jump'
alias m='mark'
alias c='clear'
alias q='clear && exit'
alias log='tail /var/log/system.log'
alias wget='wget -P ~/Downloads'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bash_profile'
alias src='source ~/.bash_profile'

# Git
alias gst='git status'
alias gc='git commit'

# Utilities
alias ip='curl https://icanhazip.com/'
alias mus='mosh -p 60925 us'
alias t='todo.sh -d ~/.todo.cfg -A -c'
alias vit='vim ~/Documents/ToDo/todo.txt'
alias update='brew update && brew upgrade && brew cleanup'
alias texupdate='tlmgr update --self --all --reinstall-forcibly-removed'
