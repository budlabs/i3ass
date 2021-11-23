#!/bin/bash

multi_hide(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local arg=$1 trg trgs i f1=${ori[fam1]} f2=${ori[fam2]}

  # only hide visible containers in arg
  for (( i = 0; i < ${#arg}; i++ )); do
    trg=${arg:$i:1}
    [[ ${i3list[LVI]} =~ $trg ]] && trgs+=$trg
  done

  ((${#trgs})) || return
  
  # hide whole families if present in arg and visible
  [[ $trgs =~ ${f1:0:1} && $trgs =~ ${f1:1:1} ]] \
    && trgs=${trgs//[$f1]/} && family_hide "$f1"
  
  [[ $trgs =~ ${f2:0:1} && $trgs =~ ${f2:1:1} ]] \
    && trgs=${trgs//[$f2]/} && family_hide "$f2"

  # hide rest if any
  ((${#trgs})) && for ((i=0;i<${#trgs};i++)); do
    container_hide "${trgs:$i:1}"
  done
}
