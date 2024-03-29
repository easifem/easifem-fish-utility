function erun -d "efficient easifem run"
    set -l currentPath ( pwd )

    argparse \
        c/classes b/base \
        a/acoustic e/elasticity \
        d/directory 'n/modname=' -- $argv
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

    if count $argv >/dev/null
        easifem run -e $eflag -f $argv
    else
        if set -ql _flag_directory
            set dirname (fd --type d | fzf )
            easifem run -e $efrag -f (find $dirname  -name "*.[fF]*" -o -name "*.md" -type f | fzf )
        else
            easifem run -e $eflag -f (find . -name "*.[fF]*" -o -name "*.md" -type f | fzf )
        end
    end

    builtin cd $currentPath
end
