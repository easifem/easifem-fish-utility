function ecp -d "efficient copy of easifem toml files"
    set -l currentPath (pwd)
    if set -q EASIFEM_PYTHON_CLI
        echo "easifem by python cli cannot use this utility"
        return 1
    end

    argparse a/all l/linter c/config r/runner -- $argv
    or return 1

    builtin cd $HOME/.config/easifem

    if set -ql _flag_all
        cp -i *.toml $currentPath
        builtin cd $currentPath
        return
    end


    set filename

    if set -ql _flag_linter
        set filename $filename "linter.toml"
    end

    if set -ql _flag_config
        set filename $filename "easifem.toml"
    end

    if set -ql _flag_runner
        set filename $filename "runner.toml"
    end

    if test "$filename" = ""
        set filename (fd --type f -e toml | fzf -m )
    end

    cp -i $filename $currentPath

    builtin cd $currentPath

end
