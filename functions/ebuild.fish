
function ebuild -d "efficient build for easifem"
    if set -q EASIFEM_PYTHON_CLI
        _ebuild_python $argv
    else
        _ebuild_go $argv
    end
end

function _ebuild_python
    set currentPath ( pwd )

    argparse d/debug -- $argv

    if set -ql _flag_debug
        echo "debug mode is selected "
        set script build.py
    else
        echo "release mode is selected "
        set script release_build.py
    end

    switch $argv
        case "?*"
            builtin cd $$argv
    end

    python3 $script

    builtin cd $currentPath
end

function _ebuild_go
    argparse q/quiet d/download c/clean "e/env=" -- $argv

    if set -ql _flag_env
        set env --env $_flag_env
    else
        set env
    end

    if set -ql _flag_env
        echo "clean before installation"
        easifem clean $argv $env
    end

    if set -ql _flag_quiet
        set env -q $env
    end

    easifem dev $argv $env
    return
end
