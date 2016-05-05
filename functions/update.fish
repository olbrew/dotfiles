function update
    echo "🆕  Updating System (root)"
    sudo softwareupdate --install -all
    echo \n

    echo "🆕  Updating Brew"
    brew update
    brew upgrade --all
    brew cleanup
    brew cask cleanup
    brew prune
    echo \n

    echo "🆕  Updating Vim"
    nvim +PlugUpdate +qall
    echo \n

    #echo "🆕  Updating Python"
    # still no master pip update command
    echo \n

    echo "🆕  Updating Node"
    npm -g update
    echo \n

    echo "🆕  Updating Tex"
    tlmgr update --self --all --reinstall-forcibly-removed
    echo \n

    echo "🆕  Updating Fish"
    fish_update_completions
    echo \n

    echo "✅  Succes! You are fully up to date now. 👍 🤓 "
end
