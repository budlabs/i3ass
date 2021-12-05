#!/bin/bash

container_create() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local target=$1

  messy "[con_id=${i3list[TWC]}]"       \
    floating disable,                   \
    move --no-auto-back-and-forth to workspace "${i3list[WFN]}"
  [[ ${i3list["X${ori[main]}"]} ]] && {
    messy "[con_mark=i34X${ori[main]}]" \
      split "${ori[charmain]}"
    messy "[con_id=${i3list[TWC]}]" \
      move to mark "i34X${ori[main]}"
  }

  messy "[con_id=${i3list[TWC]}]" \
    split "${ori[charmain]}",       \
    layout tabbed,                \
    focus, focus parent

  messy mark "i34$target"
}
