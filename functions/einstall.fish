function einstall -d "efficient install for easifem"
    if set -q EASIFEM_PYTHON_CLI
        _einstall_python $argv
    else
        _einstall_go $argv
    end
end

function _einstall_python
    set currentPath ( pwd )

    argparse d/debug -- $argv

    if set -ql _flag_debug
        echo "debug mode is selected "
        set script install.py
    else
        echo "release mode is selected "
        set script release_install.py
    end

    switch $argv
        case "?*"
            builtin cd $$argv
            set repoName $argv
        case ""
            set repoName ( basename $currentPath )
            set argv ( basename $currentPath )
    end

    switch $repoName
        case acoustic elasticity
            set repoName kernels
    end

    set branchName ( git branch --show-current 2> /dev/null )

    if test "$branchName" = ""
        echo "There is not git repository"
        echo "date is used instead of branch name"
        set branchName (  date +%Y-%m-%d )
    end

    if [ -f $script ]
        set flagName ( cat $EASIFEM_INSTALL_DIR/easifem/$repoName/flag )
        if not test "$flagName" = "$branchName"

            echo "Flag name and Branch name is different"
            echo -n "Flag name -> "
            echo $flagName
            echo "Branch name -> "$branchName
            echo "Do you want to overwrite ? [Y/n] :"
            set ans (read)

            switch $ans
                case Y y ""

                    echo "Do you want to clean before installation ? [y/N] :"
                    set ans2 (read)
                    switch $ans2
                        case Y y
                            easifem clean $argv
                    end

                    python3 $script
                    echo $branchName >$EASIFEM_INSTALL_DIR/easifem/$repoName/flag

                case N n "?*"
                    echo "instalation is skipped "
                    echo "please try backup_easifem for making backup"
                    return 0
            end
        else

            echo "Do you want to clean before installation ? [y/N] :"
            set ans2 (read)
            switch $ans2
                case Y y
                    easifem clean $argv
            end

            python3 $script
            echo $branchName >$EASIFEM_INSTALL_DIR/easifem/$repoName/flag
        end
        builtin cd $currentPath
        return
    end
    echo "python file is not found "
    builtin cd $currentPath
    return 1
end

function _einstall_go
    argparse q/quiet d/download c/clean "e/env=" -- $argv

    if set -ql _flag_env
        set env --env $_flag_env
    else
        set env
    end

    if set -ql _flag_clean
        echo "clean before installation"
        easifem clean $argv $env
    end

    if set -ql _flag_quiet
        set env -q $env
    end

    if set -ql _flag_download
        easifem install $argv $env
    else
        # default is with no-download option
        easifem install $argv --no-download $env
    end
    return

end
