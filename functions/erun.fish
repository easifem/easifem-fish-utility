function erun -d "efficient easifem run"
    if set -q EASIFEM_PYTHON_CLI
        _erun_python $argv
    else
        _erun_go $argv
    end
end

function _erun_python
    set -l currentPath ( pwd )

    argparse \
        c/classes b/base \
        a/acoustic e/elasticity \
        s/smartout q/quiet \
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
        set eflag (echo -e $cands | fzf -m )
    end

    if set -ql _flag_quiet
        set run run -q
    else
        set run run
    end

    if count $argv >/dev/null
        set filename $argv
        set eflag (_get_easifem_flag $filename)
    else
        if set -ql _flag_directory
            set dirname (fd --type d | fzf )
            set filename (fd $dirname --type f -e md -e F90 -e f90 | fzf )
        else
            set filename (fd .  --type f -e md -e F90 -e f90 | fzf )
        end
    end

    if set -ql _flag_smartout
        easifem $run -e $eflag -f $filename >tmp_erun
        _easifem_output_reshape tmp_erun
        rm -f tmp_erun
    else
        easifem $run -e $eflag -f $filename
    end

    builtin cd $currentPath
end

function _erun_go
    set -l currentPath ( pwd )

    argparse q/quiet d/directory -- $argv
    or return 1

    if set -ql _flag_quiet
        set run run -q
    else
        set run run
    end

    if count $argv >/dev/null
        set filename $argv
    else
        if set -ql _flag_directory
            set dirname (fd --type d | fzf )
            set filename (fd $dirname --type f -e md -e F90 -e f90 | fzf -m )
        else
            set filename (fd . --type f -e md -e F90 -e f90 | fzf -m )
        end
    end

    easifem $run $filename

    builtin cd $currentPath
end
