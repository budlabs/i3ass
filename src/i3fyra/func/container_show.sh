#!/bin/bash

container_show() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local target=$1 target_family

  [[ ${#target} -gt 1 ]] && {
    multi_show "$target"
    return
  }

  [[ ${ori[fam1]} =~ $target ]] \
    && target_family=${ori[fam1]} \
    || target_family=${ori[fam2]}

  if [[ ${i3list[LVI]} =~ $target ]]; then
    return
  elif [[ ! ${i3list[LHI]} =~ $target ]]; then
    container_create "$target"
  elif [[ ${i3list["N$target_family"]} = "${i3list[WFN]}" ]]; then
    messy "[con_mark=i34${target}]"       \
      move --no-auto-back-and-forth to workspace "${i3list[WFN]}", \
      floating disable
  fi

  family_show "$target_family" "$target"

  i3list[LHI]=${i3list[LHI]/$target/}
  i3list[LVI]+=$target
  i3list[LEX]="${i3list[LHI]}${i3list[LVI]}"

  [[ ${i3list["N${target_family}"]} = "${i3list[WFN]}" ]] && {
    messy "[con_mark=i34$target]" \
      move to mark "i34X$target_family"

    [[ $target = "${target_family:0:1}" ]] && {
      messy "[con_mark=i34$target]" \
        swap mark "i34${target_family:1:1}"
    }

    tspl=${i3list[M${target_family}]}
    tdim=${ori[sizefam]}

    ((tspl  )) && {
      i3list[S${target_family}]=$((tdim/2))
      apply_splits "${target_family}=$tspl"
    }
  }
}
