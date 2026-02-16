function hx --wraps hx
    set startpath $(pwd)
    cd $(realpath ./)
    /usr/bin/hx $argv
    cd $startpath
end
