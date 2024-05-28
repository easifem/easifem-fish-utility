function switch_easifem -d "switch easifem install directory to backuped one"
    set currentPath ( pwd )
    builtin cd $EASIFEM_INSTALL_DIR/easifem

    if command -q fzf
        set after ( find . -name $argv"*" -type d | sed 's/\.\///' | fzf )
    else
        echo "This function require fzf command"
        return 1
    end

    if test "$after" = ""
        echo "switch_easifem skipped "
        builtin cd $currentPath
        return 0
    end

    if [ -f $EASIFEM_INSTALL_DIR/easifem/$argv/flag ]
        set suffix ( cat $argv/flag )
    else
        set suffix ( date +%Y-%m-%d )
    end

    if [ -d $EASIFEM_INSTALL_DIR/easifem/$argv'-'$suffix ]
        set aint ( find . -name $argv'-'$suffix"*" | wc -l )
        mv $argv $argv'-'$suffix"("$aint")"
        echo "previous " $argv "dir renamed as " $argv'-'$suffix"("$aint")"
    else
        mv $argv $argv'-'$suffix
        echo "previous " $argv "dir renamed as " $argv'-'$suffix
    end

    mv $after $argv

    builtin cd $currentPath
end
