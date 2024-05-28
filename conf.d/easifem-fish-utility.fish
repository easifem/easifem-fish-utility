if command -q easifem
    if which easifem | grep go >/dev/null
        if [ -f $HOME/.config/easifem/easifemvar.fish ]
            source $HOME/.config/easifem/easifemvar.fish
        end
        set -e EASIFEM_PYTHON_CLI
    else
        set -gx EASIFEM_INSTALL_DIR ~/.easifem/install
        set -gx EASIFEM_BUILD_DIR ~/.easifem/build
        set -gx EASIFEM_SOURCE_DIR ~/.easifem/src
        set -gx EASIFEM_BASE ~/.easifem/install/easifem/base
        set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $EASIFEM_BASE/lib
        set -gx EASIFEM_CLASSES ~/.easifem/install/easifem/classes
        set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $EASIFEM_CLASSES/lib
        set -gx EASIFEM_EXTPKGS ~/.easifem/install/easifem/extpkgs
        set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $EASIFEM_EXTPKGS/lib
        set -gx EASIFEM_APP ~/.easifem/install/easifem/app
        set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $EASIFEM_APP/lib
        set -gx EASIFEM_MATERIALS ~/.easifem/install/easifem/materials
        set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $EASIFEM_MATERIALS/lib
        set -gx EASIFEM_KERNELS ~/.easifem/install/easifem/kernels
        set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $EASIFEM_KERNELS/lib
        set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH $EASIFEM_EXTPKGS/lib/pkgconfig
        set -gx PATH $PATH $EASIFEM_EXTPKGS/bin
        set -gx PATH $PATH $EASIFEM_APP/bin
        set -gx EASIFEM_PYTHON_CLI
    end
else
    echo "easifem command is unknown"
end
