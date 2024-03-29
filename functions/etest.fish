function etest -d "efficient easifem test"
    set -l currentPath ( pwd )

    argparse \
        c/classes b/base \
        a/acoustic e/elasticity \
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

    echo $eflag

    builtin cd $docs
    set -l test_dir $docs/(fd --type d | fzf)
    builtin cd $test_dir
    easifem run -e $eflag -f (fd -I --type f -e md -e F90 -e f90  | fzf )
    builtin cd $myloc

    builtin cd $currentPath
end
