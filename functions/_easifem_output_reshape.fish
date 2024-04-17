function _easifem_output_reshape -d "reshape output messages"

    if not count $argv >/dev/null
        echo "a text file input is necessary"
        return 1
    end

    set rownum (grep -n 'Config App .* Failed' $argv | cut -f 1 -d :)
    if not test "$rownum" = ""
        echo "!! CONFIG ERROR IS DETECTED !!"
        set rownum (math $rownum + 1)
        tail $argv -n "+"$rownum | head -n -2
        return 0
    end

    set rownum (grep -n 'Building App .* Failed' $argv | cut -f 1 -d :)
    if not test "$rownum" = ""
        echo "!! BUILDING ERROR IS DETECTED !!"
        set rownum (math $rownum + 1)
        tail $argv -n "+"$rownum | head -n -2
        return 0
    end

    set rownum (grep -n 'Running App .* Failed' $argv | cut -f 1 -d :)
    if not test "$rownum" = ""
        echo "!! RUNNING ERROR IS DETECTED !!"
        set rownum (math $rownum + 1)
        tail $argv -n "+"$rownum | head -n -2
        return 0
    end

    set rownum (grep -n 'Running App' $argv | cut -f 1 -d :)
    if not test "$rownum" = ""
        set rownum (math $rownum + 1)
        tail $argv -n "+"$rownum | head -n -2
        return 0
    end

end
