# Marks functionality
export MARKPATH=$HOME/.marks
function jump {
cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
rm -i "$MARKPATH/$1"
}
function marks {
(t="$(printf "\t")"; cd $MARKPATH && stat -f"%N$t%SY" * | column -ts"$t")
}

# Completion for Marks
_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}
complete -F _completemarks jump unmark

# Systemwide search
search()
{
    find / -iname "*$1*" -print -o -type d -name "Volumes" -prune 2>/dev/null;
}

# Todo desktop folders
function todo {
    set -e
    touch ~/Desktop/"$*"
}
