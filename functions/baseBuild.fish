function baseBuild -d "replacement of python3 install.py"
    set -l myloc (pwd)
    set -l srcdir $base

    set -l build_dir $EASIFEM_BUILD_DIR/"/easifem/base/build"
    mkdir -pv $build_dir

    builtin cd $srcdir
    cmake -S . -B $build_dir -G Ninja -D USE_OpenMP:BOOL=ON -D CMAKE_BUILD_TYPE:STRING=Debug -D BUILD_SHARED_LIBS:BOOL=ON -D USE_PLPLOT:BOOL=ON -D CMAKE_INSTALL_PREFIX:PATH=$EASIFEM_BASE -D USE_BLAS95:BOOL=ON -D USE_LAPACK95:BOOL=ON -D USE_FFTW:BOOL=ON -D USE_GTK:BOOL=OFF -D USE_ARPACK:BOOL=ON -D USE_SUPERLU:BOOL=ON -D USE_LIS:BOOL=ON -D USE_PARPACK:BOOL=OFF -D USE_METIS:BOOL=OFF -D USE_LUA:BOOL=ON -D USE_Int32:BOOL=ON -D USE_Real64:BOOL=ON -D COLOR_DISP:BOOL=OFF -D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON

    echo $cmake_def

    cmake --build $build_dir

    builtin cd $myloc
end
