#!/bin/bash

family_hide(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local family=$1
  local child childs

  declare -i famw famh famx famy split_size
  declare -a visible_children

  split_size=$(( ( _isvertical ? i3list[WFH] : i3list[WFW] ) - i3list["S${ori[main]}"] ))
  ((split_size < 0)) && ((split_size *= -1))

  famw=$((_isvertical ? i3list[WFW] : split_size ))
  famh=$((_isvertical ? split_size : i3list[WFH]))
  famx=$((_isvertical ? 0 : i3list["S${ori[main]}"]))
  famy=$((_isvertical ? i3list["S${ori[main]}"] : 0))

  for child in "${family:0:1}" "${family:1:1}"; do
    [[ ${i3list[LVI]} =~ $child ]] \
      && visible_children+=("$child")
  done

  if ((${#visible_children[@]} == 1)); then
    child=${visible_children[0]}
    messy "[con_mark=i34$child]" \
      move scratchpad

    i3list[LVI]=${i3list[LVI]/$child/}
    i3list[LHI]+=$child

    unset 'i3list[X$family]'
    i3list[F$family]=$child
    mark_vars["i34F${family}"]=$child
  else
    messy "[con_mark=i34X${family}]"                \
      floating enable,                              \
      resize set "$famw" "$famh",                   \
      move absolute position "$famx" px "$famy" px, \
      move scratchpad

    for child in "${visible_children[@]}"; do
      i3list[LVI]=${i3list[LVI]/$child/}
      i3list[LHI]+=$child
      childs+=$child
    done

    mark_vars["i34F${family}"]=$childs
    mark_vars["i34M${family}"]=${i3list[S${family}]:=0}
  fi

  mark_vars["i34M${ori[main]}"]=${i3list[S${ori[main]}]:=0}

}
