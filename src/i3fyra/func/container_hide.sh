#!/bin/bash

container_hide(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local target=$1
  local target_family sibling
  declare -i split_main split_family

  [[ ${#target} -gt 1 ]] && {
    multi_hide "$target"
    return
  }

  [[ ${ori[fam1]} =~ $target ]] \
    && target_family=${ori[fam1]} \
    || target_family=${ori[fam2]}


  split_main=${i3list[S${ori[main]}]:=0}
  split_family=${i3list[S$target_family]:=0}

  sibling=${target_family/$target/}

  messy "[con_mark=i34${target}]" move scratchpad
  i3list[LVI]=${i3list[LVI]/$target/}
  i3list[LHI]+="$target"

  # if target is last of it's fam, note it.
  # else focus sibling as the last operation (main())
  [[ ${i3list[LVI]} =~ $sibling ]]         \
    && i3list[SIBFOC]=$sibling             \
    || mark_vars["i34F${target_family}"]=$target

  # note splits
  ((split_main && split_main != ori[sizemain])) && {
    mark_vars["i34M${ori[main]}"]=$split_main
    i3list[M${main}]=$split_main
    mark_vars["i34M${target_family}"]=$split_family
    i3list[M${target_family}]=$split_family
  }

}
