#!/bin/env bash

containerhide(){
  local trg tfam famchk

  trg=$1

  [[ ${#trg} -gt 1 ]] && multihide "$trg" && return

  [[ $trg =~ A|C ]] && tfam=AC || tfam=BD
  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ $trg =~ A|B ]] && tfam=AB || tfam=CD
  fi

  i3-msg -q "[con_mark=i34${trg}]" focus, floating enable, \
    move absolute position 0 px 0 px, \
    resize set $((i3list[WFW]/2)) px $((i3list[WFH]/2)) px, \
    move scratchpad
  # add to trg to hid
  i3list[LHI]+=$trg
  i3list[LVI]=${i3list[LVI]/$trg/}
  i3list[LVI]=${i3list[LVI]:-X}

  # if trg is last of it's fam, note it.
  # else focus sib
  [[ ! ${tfam/$trg/} =~ [${i3list[LVI]}] ]] \
    && i3var set "i34F${tfam}" "$trg" \
    || i3list[SIBFOC]=${tfam/$trg/}

  # note splits
  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ -n ${i3list[SAC]} ]] && ((i3list[SAC]!=i3list[WFH])) && {
      i3var set "i34MAC" "${i3list[SAC]}"
      i3list[MAC]=${i3list[SAC]}
    }

    [[ -n ${i3list[S${tfam}]} ]] && ((${i3list[S${tfam}]}!=i3list[WFW])) && {
      i3var set "i34M${tfam}" "${i3list[S${tfam}]}" 
      i3list[M${tfam}]=${i3list[S${tfam}]}
    }
  else
    [[ -n ${i3list[SAB]} ]] && ((i3list[SAB]!=i3list[WFW])) && {
      i3var set "i34MAB" "${i3list[SAB]}"
      i3list[MAB]=${i3list[SAB]}
    }

    [[ -n ${i3list[S${tfam}]} ]] && ((${i3list[S${tfam}]}!=i3list[WFH])) && {
      i3var set "i34M${tfam}" "${i3list[S${tfam}]}" 
      i3list[M${tfam}]=${i3list[S${tfam}]}
    }
  fi
}

multihide(){
  local trg real i

  trg="$1"

  for (( i = 0; i < ${#trg}; i++ )); do
    [[ ${trg:$i:1} =~ [${i3list[LVI]}] ]] && real+=${trg:$i:1}
  done

  [[ -z $real ]] && return
  [[ ${#real} -eq 1 ]] && containerhide "$real" && return
  
  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ "A" =~ [$real] ]] && [[ "B" =~ [$real] ]] \
      && real=${real/A/} real=${real/B/} && familyhide AB
    [[ "C" =~ [$real] ]] && [[ "D" =~ [$real] ]] \
      && real=${real/C/} real=${real/D/} && familyhide CD
  else
    [[ "A" =~ [$real] ]] && [[ "C" =~ [$real] ]] \
      && real=${real/A/} real=${real/C/} && familyhide AC
    [[ "B" =~ [$real] ]] && [[ "D" =~ [$real] ]] \
      && real=${real/B/} real=${real/D/} && familyhide BD
  fi

  for (( i = 0; i < ${#real}; i++ )); do
    containerhide "${real:$i:1}"
  done
}
