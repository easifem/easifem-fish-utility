function edoc -d "open a easifem doc file in nvim"
    set -l myloc (pwd)
    cd $docs
    cd $docs/(fd --type d | fzf)
    nvim (fd --type f | fzf )
    cd $myloc
end
