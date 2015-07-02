function aliases
    # Core tools
    balias l "ls"
    balias ls "ls -lhG"
    balias ll "ls -lhaG"
    balias g "git"
    balias j "jump"
    balias m "mark"
    balias c "clear"
    balias q "clear; exit"
    balias log "tail /var/log/system.log"
    balias vimrc "vim ~/.vimrc"
    balias src "source ~/.config/fish/config.fish"
    balias c++ "clang++ -std=c++14 -Wall -Wextra"

    # Utilities
    balias ip "curl https://icanhazip.com/"
    balias t "todo.sh -d ~/.todo.cfg -A -c"
    balias vit "vim ~/Documents/Personal/todo.txt"
    balias vis "vim ~/Documents/Personal/schedule.md"
    balias bru "brew update; brew upgrade --all; brew cleanup; brew cask cleanup; brew prune"
    balias texu "tlmgr update --self --all --reinstall-forcibly-removed"
    balias axel "axel -o ~/Downloads"
    balias yt "youtube-dl -o '~/Downloads/%(title)s.%(ext)s'"

    # Temp c2p shortcuts
    balias grun "java org.antlr.v4.runtime.misc.TestRig"
end
