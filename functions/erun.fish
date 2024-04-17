function erun -d "efficient easifem run"
    set -l currentPath ( pwd )

    argparse \
        c/classes b/base \
        a/acoustic e/elasticity \
        s/smartout \
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

    if count $argv >/dev/null
        set filename $argv
        set eflag (_get_easifem_flag $filename)
    else
        if set -ql _flag_directory
            set dirname (fd --type d | fzf )
            set filename (find $dirname  -name "*.[fF]*" -o -name "*.md" -type f | fzf )
        else
            set filename (find . -name "*.[fF]*" -o -name "*.md" -type f | fzf )
        end
    end

    if set -ql _flag_smartout
        easifem run -e $eflag -f $filename >tmp_erun
        _easifem_output_reshape tmp_erun
        rm -f tmp_erun
    else
        easifem run -e $eflag -f $filename
    end
    builtin cd $currentPath
end
