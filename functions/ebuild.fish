
function ebuild -d "efficient build for easifem"
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
