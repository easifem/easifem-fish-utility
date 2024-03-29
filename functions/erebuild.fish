function erebuild -d "Rebuild entire easifem library"
    set currentPath $pwd
    argparse d/debug -- $argv
    if set -ql _flag_debug
        echo "You have selected DEBUG mode"
        echo "DEBUG version of easifem will be built"
        set script install.py
    else
        echo "release mode is selected "
        set script release_install.py
    end

    set mylists base classes elasticity acoustic
    set mypaths $base $classes $elasticity $acoustic

    if count $argv >/dev/null
        easifem clean $mylists $argv
    else
        easifem clean $mylists
    end

    for ipath in $mypaths
        cd $ipath
        python3 $script
    end
    cd $currentPath
end
