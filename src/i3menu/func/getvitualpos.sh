#!/bin/bash

getvirtualpos() {

  local target=$1

  # block below sets "virtual" i3fyra position i3list[VPx]
  [[ ${target:=${_o[layout]}} =~ A|B|C|D ]] && {
    declare -i vpos
    q=([0]=A [1]=B [2]=C [3]=D)
    for k in "${!q[@]}"; do
      vpos=${i3list[VP${q[$k]}]:=$k}
      # if target=A , i3list[VPA]=2 -> target=@@2
      (( k != vpos )) && [[ $target =~ ${q[k]} ]] \
        && target=${target//${q[$k]}/@@$vpos}
    done

    [[ $target =~ @@ ]] && for k in "${!q[@]}"; do
      # if k=2, target=@@2, q[2]=C -> target=C
      target=${target//@@$k/${q[$k]}}
    done
  }

  echo "$target"
}
