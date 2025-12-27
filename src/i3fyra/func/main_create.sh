#!/bin/bash

main_create() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"

  local creating_family=$1

  [[ ${i3list["X${ori[main]}"]} ]] || {
    
    [[ $creating_family =~ [ABCD]{1,2} ]] \
      || ERX "cannot create layout, invalid family: '${creating_family}'"

    messy "[con_mark=i34X${creating_family}]" \
      layout split"${ori[charmain]}", \
      focus, focus parent
    messy mark "i34X${ori[main]}"

    i3list["X${ori[main]}"]=${i3list[WSF]}
  }
}
