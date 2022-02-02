function update -d "Update all tools and applications on MacOS"
    if nc -z google.com 80  >/dev/null 2>&1
        echo "🍎 Updating System (root)"
        sudo softwareupdate --install -all
        echo \n

        echo "🍺 Updating Brew"
        brew update
        brew upgrade
        brew upgrade --cask
        brew cleanup
        echo \n

        echo "💎 Updating Ruby Gems"
        sudo gem update
        echo \n

        echo "🐍 Updating Python"
        pip list --outdated | awk '{print $1}' | xargs -n1 pip install -U
        echo \n

        echo "✏️ Updating NeoVim"
        nvim +PlugUpgrade +PlugUpdate +qall
        echo \n

        echo "📦 Updating NPM"
        npm -g update
        echo \n

        echo "🐡 Updating Fish Plugins and Completions"
        fundle self-update
        fundle update
        fish_update_completions --keep
        echo \n

        echo "📒 Updating TLDR"
        tldr --update
        echo \n

        echo "📂 Cleaning stale directories from z cache"
        z --clean
        echo \n

        echo "Succes! You are fully up to date now. 👍 "
    else
        echo "You are currently not connected to the internet. Try again later."
    end
end
