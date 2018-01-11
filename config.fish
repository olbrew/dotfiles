# Remove fish default greeting
set fish_greeting

## Vi keybindings
fish_vi_key_bindings

## Abbreviations
if status --is-interactive
    set -g fish_user_abbreviations
    abbr --add c clear
    abbr --add g git
    abbr --add b brew
    abbr --add ls 'exa -lha --sort=modified --git'
    abbr --add l 'exa -1 --sort=modified'
    abbr --add q 'clear; exit'
    abbr --add log 'tail /var/log/system.log'
    abbr --add src 'source ~/.config/fish/config.fish'
    abbr --add c++ 'clang++ -std=c++14 -Wall -Wextra'
    abbr --add yt 'youtube-dl -o "~/Downloads/%(title)s.%(ext)s"'
    abbr --add hn 'nvim -c HackerNews'
    abbr --add bc 'brew cask'
    abbr --add whip 'dig TXT +short o-o.myaddr.l.google.com @ns1.google.com'
    abbr --add rg 'rg -pS'
    abbr --add wt 'webtorrent --blocklist "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz" --iina download'
end

## Environment variables
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
# Kryptco
set -x GPG_TTY (tty)
