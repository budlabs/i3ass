#!/usr/bin/env bash

getdeps(){
  for d in "$___dir/ass/"*; do
    nejm="${d##*/}"
    deps["$nejm"]="$(
      "$d/${nejm}.sh" --help 2>&1 | awk '
        start==1 && $0 !~ /^[[:space:]]*[-]*[[:space:]]*$/ && $1 !~ /^i3.*/ {print $1}
        $1 == "DEPENDENCIES" {start=1}
    ')"
  done

  alldeps=($(printf '%s\n' ${deps[@]} | sort -u))
}
