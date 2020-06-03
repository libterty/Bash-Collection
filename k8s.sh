#!/bin/bash

auto_start_k8s() {
  files=($(find -E . -type f -regex "^.*.yaml$"))
  for item in ${files[*]}; do
    kubectl apply -f $item
  done
}

main() {
  if [ $1 = 'a' ]; then
    auto_start_k8s
  fi
}

main
