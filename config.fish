# Platform agnostic configuration
## Remove fish default greeting
set fish_greeting

## Set blinking cursor
set fish_cursor_default block blink

## Vi keybindings
fish_vi_key_bindings

## Fundle
### Install Fundle if not present
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
### Plugins
fundle plugin 'IlanCosman/tide'
fundle plugin 'jethrokuan/z'
fundle plugin 'PatrickF1/fzf.fish'
fundle plugin 'Gazorby/fish-abbreviation-tips'
fundle plugin 'danhper/fish-fastdir'
fundle plugin 'lilyball/nix-env.fish'
fundle plugin 'danhper/fish-ssh-agent'

fundle init

## Abbreviations
abbr --add --global g git;
abbr --add --global l 'exa'
abbr --add --global ls 'exa -l --sort=modified'
abbr --add --global la 'exa -la --sort=modified'
abbr --add --global find 'fd'
abbr --add --global cat 'bat'
abbr --add --global less 'bat'
abbr --add --global grep 'rg'
abbr --add --global rg 'rg -pS -M 200'
abbr --add --global src 'source ~/.config/fish/config.fish'
abbr --add --global whip 'dig TXT +short o-o.myaddr.l.google.com @ns1.google.com'

## Environment variables
### Set default user to hide hostname in prompt
set -x DEFAULT_USER o
### Set locale
set -x LC_ALL 'en_US.UTF-8'
### Editor
set -x EDITOR 'nvim'
### Use fd as default command for fzf
set -x FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'
set -x FZF_CTRL_T_COMMAND '$FZF_DEFAULT_COMMAND'

# Platform specific configuration
switch (uname)
case Darwin ## Mac
    ### Abbreviatons
    abbr --add --global log 'tail /var/log/system.log'
    abbr --add --global mrpi 'mosh -p 62852 rpi4'
    abbr --add --global yt 'youtube-dl -o "~/Downloads/%(title)s.%(ext)s"'
    abbr --add --global wt 'webtorrent --blocklist "https://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz" -o ~/Downloads/ download'

    ### Environment variables
    #### Prevent ._* files from being written
    set -x COPYFILE_DISABLE 'true'
    #### No insecure redirect for homebrew
    set -x HOMEBREW_NO_INSECURE_REDIRECT 'true'
    #### Disable homebrew analytics
    set -x HOMEBREW_NO_ANALYTICS 1
    ## Kryptco
    set -x GPG_TTY (tty)

case Linux ## Linux
    ### Abbreviations
    abbr --add --global log 'tail /var/log/syslog'
    abbr --add --global yt 'youtube-dl -o "/media/rpool/video/Short/%(title)s.%(ext)s"'
    abbr --add --global temp 'echo "RPI4 CPU temperature is" (expr (cat /sys/class/thermal/thermal_zone0/temp) / 1000) "degrees celcius"'

    ### Environment variables
    #### Nix locale fix on non-NixOS
    set -x LOCALE_ARCHIVE '/usr/lib/locale/locale-archive'

    ### Byobu config
end
status --is-login; and status --is-interactive; and exec byobu-launcher
