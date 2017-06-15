# Options
set global tabstop 4
set global indentwidth 4
set global grepcmd "rg -pS --vimgrep"

# Use "jj" as escape 
hook global InsertChar j %{ try %{
	exec -draft hH <a-k>jj<ret> d
      exec <esc>
}}

# Indent spaces with <TAB>
map global insert <tab> '<a-;><gt>'

# Show line numbers
hook global WinCreate .* %{addhl number_lines}

# Autowrap
hook global WinCreate .* %{ autowrap-enable }

# Use system clipboard
hook global NormalKey y|d|c %{ nop %sh{
	printf %s "$kak_reg_dquote" | pbcopy
}}

# ,w shows amount of words in selection
map global user 'w' %{:echo %sh{wc -w <lt><lt><lt> "${kak_selection}"}<ret>}

# Filetype specific options
hook global WinSetOption filetype=cpp %{
    	clang-enable-autocomplete
    	clang-enable-diagnostics
    	set window fromatcmd 'astyle'
}

hook global WinSetOption filetype=javascript %{
      set window formatcmd 'prettier'
}

hook global WinSetOption filetype=json %{
      set window formatcmd 'jq'
}

hook global WinSetOption filetype=python %{
      set window formatcmd 'autopep8'
}
