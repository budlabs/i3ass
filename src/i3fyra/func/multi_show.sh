#!/bin/bash

multi_show(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local arg=$1 trg trgs i f1=${ori[fam1]} f2=${ori[fam2]}

  # only show hidden containers in arg
  for (( i = 0; i < ${#arg}; i++ )); do
    trg=${arg:$i:1}
    [[ ${i3list[LHI]} =~ $trg ]] && trgs+=$trg
  done

  ((${#trgs})) || return

  # show whole families if present in arg and hidden
  [[ $trgs =~ ${f1:0:1} && $trgs =~ ${f1:1:1} ]] \
    && trgs=${trgs//[$f1]/} && family_show "$f1"
  
  [[ $trgs =~ ${f2:0:1} && $trgs =~ ${f2:1:1} ]] \
    && trgs=${trgs//[$f2]/} && family_show "$f2"

  # show rest if any
  ((${#trgs})) && for ((i=0;i<${#trgs};i++)); do
    single=${trgs:$i:1}
    container_show "$single"
  done
}
