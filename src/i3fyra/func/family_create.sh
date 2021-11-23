#!/bin/bash

family_create() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"

  local target_family=$1 target_container=$2

  if [[ ${i3list["X${ori[main]}"]} ]]; then
    messy "[con_mark=i34X${ori[main]}]" \
      split h
    messy "[con_mark=i34$target_container]" \
      move to workspace "${i3list[WSF]}", \
      floating disable, \
      move to mark "i34X${ori[main]}", split h, \
      layout splitv, \
      focus, focus parent
    messy mark "i34X$target_family"
  else
    messy "[con_mark=i34$target_container]" \
      move to workspace "${i3list[WSF]}", \
      floating disable, \
      layout splitv, \
      focus, focus parent
    messy mark "i34X$target_family"
    messy "[con_mark=i34X$target_family]" \
      layout splith, \
      focus, focus parent
    messy mark "i34X${ori[main]}"
  fi
}
