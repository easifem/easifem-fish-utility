function evim -d "open file with vim"
    nvim ( fd -I --type f -e md -e F90 -e f90  | fzf )
end
