function _get_easifem_flag -d "get module flag for easifem"
    if not count $argv >/dev/null
        echo "a input file is necessary"
        return 1
    end

    if grep -q "USE easifemElasticity" $argv
        echo easifemElasticity
        return 0
    end

    if grep -q "USE easifemAcoustic" $argv
        echo easifemAcoustic
        return 0
    end

    if grep -q "USE easifemClasses" $argv
        echo easifemClasses
        return 0
    end

    if grep -q "USE easifemBase" $argv
        echo easifemBase
        return 0
    end
end
