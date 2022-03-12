#!/bin/bash

# takes a string with one or more container names (ABCD)
# returns virtual positions for the containers
virtual_position() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"

  local target=$1
  declare -i vpos k
  declare -a q

  # if target is A && i3list[VPA] == 2
  # then target=@@2 -> target=C

  [[ $target =~ ^[ABCD=[:space:]]+$ ]] && {
    
    q=([0]=A [1]=B [2]=C [3]=D)

    for k in 0 1 2 3; do
      vpos=${i3list[VP${q[$k]}]:=$k}
      (( k != vpos )) && [[ $target =~ ${q[k]} ]] \
        && target=${target//${q[$k]}/@@$vpos}
    done

    [[ $target =~ @@ ]] && for k in 0 1 2 3; do
      target=${target//@@$k/${q[$k]}}
    done

  }

  echo "$target"
}
