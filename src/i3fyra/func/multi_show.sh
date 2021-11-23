#!/bin/bash

multi_show(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local arg=$1 trg trgs i f1=${ori[fam1]} f2=${ori[fam2]}

  # only show hidden containers in arg
  for (( i = 0; i < ${#arg}; i++ )); do
    trg=${arg:$i:1}
    [[ ${i3list[LHI]} =~ $trg ]] \
      && container_show "$trg"
  done
}
