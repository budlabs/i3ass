#!/bin/bash

varset() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}(${mark_vars[*]})"

  local key val re  current_value

  for key in "${!mark_vars[@]}"; do
    unset current_value
    val=${mark_vars[$key]}

    re="\"${key}=([^\"]*)\""

    [[ $_marks_json =~ $re ]] && current_value=${BASH_REMATCH[1]}

    [[ $current_value = "$val" ]] && continue

    new_mark="${key}=$val"
    old_mark="${key}=$current_value"

    # this will remove the old mark
    [[ $current_value ]] \
      && messy "[con_id=${i3list[RID]}] mark --toggle --add $old_mark"

    messy "[con_id=${i3list[RID]}] mark --add $new_mark"

  done
}
