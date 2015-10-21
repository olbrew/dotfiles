function search
    find . -iname "*$argv*" -print -o -type d -name "Volumes" -prune 2>/dev/null;
end
