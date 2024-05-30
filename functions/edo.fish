function edo -d "rerun the binary file made by easifem"
    if set -q EASIFEM_PYTHON_CLI
        _edo_python $argv
    else
        _edo_go $argv
    end
end

function _edo_python
    argparse "f/filename=" -- $argv

    if set -ql _flag_filename
        $HOME/temp/tests/build/$_flag_filename
    else
        $HOME/temp/tests/build/test
    end
end

function _edo_go
    argparse "f/filename=" -- $argv

    set bDir ./build

    if [ -f ./runner.toml ]
        if grep -iq "^builddir" ./runner.toml
            set bDir (grep -i "^builddir" ./runner.toml | cut -d '"' -f 2)
        end
    end

    if set -ql _flag_filename
        $bDir/$_flag_filename
    else
        $bDir/main.out
    end
end
