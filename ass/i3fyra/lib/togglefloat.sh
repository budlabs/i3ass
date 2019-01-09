#!/bin/env bash

togglefloat(){
  local trg

  # AWF - 1 = floating; 0 = tiled
  if ((i3list[AWF]==1)); then

    # WSA != i3fyra && normal tiling
    if ((i3list[WSA]!=i3list[WSF])); then
      i3-msg -q [con_id="${i3list[AWC]}"] floating disable
      return
    fi

    # AWF == 1 && make AWC tiled and move AWC to trg
    if [[ ${i3list[CMA]} =~ [${i3list[LVI]:-}] ]]; then
      trg="${i3list[CMA]}" 
    elif [[ -n ${i3list[LVI]:-} ]]; then
      trg=${i3list[LVI]:0:1}
    elif [[ -n ${i3list[LHI]:-} ]]; then
      trg=${i3list[LHI]:0:1}
    else
      trg="${i3list[CMA]}"
    fi

    if [[ $trg =~ [${i3list[LEX]:-}] ]]; then
      containershow "$trg"
      i3-msg -q [con_id="${i3list[AWC]}"] floating disable, \
        move to mark "i34${trg}"
    else
      # if $trg container doesn't exist, create it
      containershow "$trg"
    fi
  else
    # AWF == 0 && make AWC floating
    i3-msg -q [con_id="${i3list[AWC]}"] floating enable
  fi
}
