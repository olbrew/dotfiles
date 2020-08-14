function update -d "Update all tools and applications om MacOS"
    if nc -z google.com 80  >/dev/null 2>&1
        echo "🍎 Updating System (root)"
        sudo softwareupdate --install -all
        echo \n

        echo "🍺 Updating Brew"
        brew update
        brew upgrade
        brew cask upgrade
        brew cleanup
        echo \n

        #echo "🐍 Updating Python"
        #pip list --outdated --local | awk '{print $1;}' | xargs -n1 pip install -U
        #echo \n

        echo "✏️  Updating NeoVim"
        nvim +PlugUpgrade +PlugUpdate +qall
        echo \n

        echo "📒 Updating TLDR"
        tldr --update
        echo \n

        echo "🧶 Updating Yarn"
        yarn global upgrade
        echo \n

        echo "🐡 Updating Fish Completions"
        fish_update_completions
        echo \n

        echo "📂 Cleaning stale directories from z cache"
        z --clean
        echo \n

        echo "Succes! You are fully up to date now. 👍 "
    else
        echo "You are currently not connected to the internet. Try again later."
    end
end
