function elint -d "easifem lint utility"
    if set -q EASIFEM_PYTHON_CLI
        echo "python cli does not have linting utility now"
        return 1
    end

    argparse q/quiet -- $argv
    or return 1

    if count $argv >/dev/null
        set filename $argv
    else
        set filename (fd . --type f -e md -e F90 -e f90 | fzf -m )
    end

    if set -ql _flag_quiet
        easifem lint -q $filename
    else
        easifem lint $filename
    end
end
