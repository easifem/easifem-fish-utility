function classInstall -d "replacement of python3 install.py"
    set -l myloc (pwd)
    set -l srcdir $classes

    set -l build_dir $EASIFEM_BUILD_DIR/"/easifem/classes/build"
    mkdir -pv $build_dir

    builtin cd $srcdir
    cmake -S . -B $build_dir -G Ninja -D USE_GMSH_SDK:BOOL=ON -D CMAKE_BUILD_TYPE=Debug -D BUILD_SHARED_LIBS:BOOL=ON -D USE_LIS:BOOL=ON -D CMAKE_INSTALL_PREFIX:PATH=$EASIFEM_CLASSES

    echo $cmake_def

    cmake --build $build_dir --target install

    builtin cd $myloc
end
