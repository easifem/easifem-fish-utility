function etest -d "efficient easifem test"
    set -l currentPath ( pwd )

    argparse \
        c/classes b/base \
        a/acoustic e/elasticity \
        s/smartout q/quiet \
        'n/modname=' -- $argv
    or return 1

    set -l cands "easifemBase\neasifemClasses\neasifemAcoustic\neasifemElasticity"

    if set -ql _flag_acoustic
        set eflag easifemAcoustic
    else if set -ql _flag_elasticity
        set eflag easifemElasticity
    else if set -ql _flag_classes
        set eflag easifemClasses
    else if set -ql _flag_base
        set eflag easifemBase
    else if set -ql _flag_modname
        set eflag $_flag_modname
    else
        set eflag (echo -e $cands | fzf )
    end

    if set -ql _flag_quiet
        set run run -q
    else
        set run run
    end
    # echo $eflag

    builtin cd $docs
    set -l test_dir $docs/(fd --type d | fzf)
    builtin cd $test_dir

    if set -ql _flag_smartout
        easifem $run -e $eflag -f (fd -I --type f -e md -e F90 -e f90  | fzf ) >tmp_etest
        _easifem_output_reshape tmp_etest
        rm -f tmp_etest
    else
        easifem $run -e $eflag -f (fd -I --type f -e md -e F90 -e f90  | fzf )
    end

    builtin cd $currentPath
end
