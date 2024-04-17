
function cf_easifem -d "Check flag for each install directory"
    set -l currentPath ( pwd )

    builtin cd $EASIFEM_INSTALL_DIR/easifem

    set mylist base classes extpkgs app kernels

    for name in $mylist
        echo -n " "$name" flag = "
        echo ( cat $name/flag 2> /dev/null )
    end

    builtin cd $currentPath
end
