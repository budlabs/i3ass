#!/bin/bash

# --rotate sibling|family
rotate() {
  target=$1

  if [[ $target = family && ${i3list[AFO]} =~ [${i3list[LVI]}] ]]
    then swap_move "i34X${ori[fam1]}" "i34X${ori[fam2]}"
  elif [[ $target = sibling && ${i3list[AFS]} =~ [${i3list[LVI]}] ]]
    then swap_move "i34${i3list[AWP]}" "i34${i3list[AFS]}"
  fi
}  
