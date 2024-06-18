function eclean -d "efficient clean for easifem"
    if set -q EASIFEM_PYTHON_CLI
        _eclean_python $argv
    else
        _eclean_go $argv
    end
end

function _eclean_python
    easifem clean $argv
end

function _eclean_go
    argparse q/quiet "e/env=" -- $argv

    if set -ql _flag_env
        set env --env $_flag_env
    else
        set env
    end

    if set -ql _flag_quiet
        set env -q $env
    end

    easifem clean $argv $env
    return
end
