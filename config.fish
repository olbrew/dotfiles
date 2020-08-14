# Remove fish default greeting
set fish_greeting

## Vi keybindings
fish_vi_key_bindings

## Abbreviations
if status --is-interactive
    abbr --add --global c clear
    abbr --add --global g git
    abbr --add --global o 'open .'
    abbr --add --global b brew
    abbr --add --global ls 'exa -lh --sort=modified --git'
    abbr --add --global la 'exa -lha --sort=modified --git'
    abbr --add --global q 'clear; exit'
    abbr --add --global cat 'bat --theme=zenburn'
    abbr --add --global log 'tail /var/log/system.log'
    abbr --add --global src 'source ~/.config/fish/config.fish'
    abbr --add --global c++ 'clang++ -std=c++14 -Wall -Wextra'
    abbr --add --global yt 'youtube-dl -o "~/Downloads/%(title)s.%(ext)s"'
    abbr --add --global hn 'nvim -c HackerNews'
    abbr --add --global bc 'brew cask'
    abbr --add --global whip 'dig TXT +short o-o.myaddr.l.google.com @ns1.google.com'
    abbr --add --global rg 'rg -pS -M 200'
    abbr --add --global tmux 'tmux -f ~/.config/tmux/tmux.conf'
    abbr --add --global wt 'webtorrent --blocklist "https://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz" -o ~/Downloads/ download'
end

## Environment variables
# Set locale
set -x LC_ALL 'en_US.UTF-8'
# Editor
set -x EDITOR 'nvim'
# Compilation flags
set -x ARCHFLAGS '-arch x86_64'
# Prevent ._* files from being written
set -x COPYFILE_DISABLE 'true'
# no insecure redirect for homebrew
set -x HOMEBREW_NO_INSECURE_REDIRECT 'true'
# disable homebrew analytics
set -x HOMEBREW_NO_ANALYTICS 1
# Use rg as default command for fzf
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --smart-case --glob "!.git/*"'
# Kryptco
set -x GPG_TTY (tty)
