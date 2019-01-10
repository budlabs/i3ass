#!/bin/env bash

familyshow(){

  local fam=$1
  local tfammem="${i3list[F${fam}]}"
  # F${fam} - family memory

  famact=1
  for (( i = 0; i < ${#tfammem}; i++ )); do
    [[ ${tfammem:$i:1} =~ [${i3list[LHI]}] ]] \
      && containershow "${tfammem:$i:1}"
  done

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    i3list[SAC]=$((i3list[WFH]/2))
    applysplits "AC=${i3list[MAC]}"
  else
    i3list[SAB]=$((i3list[WFW]/2))
    applysplits "AB=${i3list[MAB]}"
  fi
}

familyhide(){
  local tfam=$1
  local trg famchk tfammem i

  for (( i = 0; i < 2; i++ )); do
    trg=${tfam:$i:1}
    if [[ ${trg} =~ [${i3list[LVI]}] ]]; then
      i3-msg -q "[con_mark=i34${trg}]" focus, floating enable, \
        move absolute position 0 px 0 px, \
        resize set \
        "$((i3list[WFW]/2))" px \
        "$((i3list[WFH]/2))" px, \
        move scratchpad

      i3list[LHI]+=$trg
      i3list[LVI]=${i3list[LVI]/$trg/}

      famchk+=${trg}
    fi
  done

  i3var set "i34F${tfam}" "${famchk}"
  i3var set "i34MAB" "${i3list[SAB]}"
  i3var set "i34M${tfam}" "${i3list[S${tfam}]}"

}

