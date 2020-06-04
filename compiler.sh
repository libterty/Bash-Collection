#!/bin/bash

compile_files() {
    files=($(find -E . -type f -regex "^.*.cc"))
    for item in ${files[*]}; do
        g++ -dynamiclib -fPIC $item
    done
}

main() {
    compile_files

    g++ main.cc -O main.exe
}

main
