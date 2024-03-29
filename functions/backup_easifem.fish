
function backup_easifem -d " make a backup for install dir "
    set currentPath ( pwd )

    if test "$$argv" = ""
        echo "variable "$argv" is not set"
        return 1
    else
        builtin cd $$argv
    end

    set branchName ( git branch --show-current 2> /dev/null )

    if test "$branchName" = ""
        echo $argv" is not git repository"
        echo "date is used instead of branch name"
        set branchName (  date +%Y-%m-%d )
    end

    builtin cd $EASIFEM_INSTALL_DIR/easifem

    switch $argv
        case acoustic elasticity

            if [ -d $EASIFEM_INSTALL_DIR/easifem/kernels'-'$branchName ]
                # TODO: ask creation 
                set aint ( find . -name kernels'-'$branchName"*" | wc -l )
                set branchName $branchName"("$aint")"
            end

            set bakName kernels-$branchName
            cp -r kernels $bakName
            echo $branchName >$bakName/flag
            echo "backup for easifem kernels is created in "$bakName

        case base classes extpkgs

            if [ -d $EASIFEM_INSTALL_DIR/easifem/$argv'-'$branchName ]
                set aint ( find . -name $argv'-'$branchName"*" | wc -l )
                set branchName $branchName"("$aint")"
            end

            set bakName $argv"-"$branchName
            cp -r $argv $bakName
            echo $branchName >$bakName/flag
            echo "backup for easifem "$argv" is created in "$bakName

        case '*'
            echo "no case found "
            echo "currently base classes extpkgs acoustic elasticity are available"
            builtin cd $currentPath
            return 1

            # TODO: for app dir 
    end

    builtin cd $currentPath
end
