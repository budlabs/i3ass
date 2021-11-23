#!/bin/bash

active_move_to_container() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local target=$1 newcont

  [[ ${i3list[LEX]} =~ $target ]] || newcont=1

  container_show "$target"

  ((newcont)) || messy "[con_id=${i3list[TWC]}]"      \
                        focus, floating disable,      \
                        move to mark "i34$target", focus
}
