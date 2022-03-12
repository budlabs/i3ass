#!/bin/bash

family_create() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"

  local target_family=$1 target_container=$2

  if [[ ${i3list["X${ori[main]}"]} ]]; then
    messy "[con_mark=i34X${ori[main]}]" \
      split "${ori[charmain]}"
    messy "[con_mark=i34$target_container]" \
      move --no-auto-back-and-forth to workspace "${i3list[WFN]}", \
      floating disable, \
      move to mark "i34X${ori[main]}", split "${ori[charmain]}", \
      layout "split${ori[charfam]}", \
      focus, focus parent
    messy mark "i34X$target_family"
  else
    messy "[con_mark=i34$target_container]" \
      move --no-auto-back-and-forth to workspace "${i3list[WFN]}", \
      floating disable, \
      layout "split${ori[charfam]}", \
      focus, focus parent
    messy mark "i34X$target_family"
    messy "[con_mark=i34X$target_family]" \
      layout "split${ori[charmain]}", \
      focus, focus parent
    messy mark "i34X${ori[main]}"
  fi
}
