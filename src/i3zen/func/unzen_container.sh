#!/bin/bash

unzen_container() {

  local trg_geo trg_ws re float_as w h y x

  # "WIDTHxHEIGHT+X+Y" || "tiled"
  [[ $_var_zen_current =~ ([^:]+):(.+) ]] && {
    trg_geo=${BASH_REMATCH[1]}
    trg_ws=${BASH_REMATCH[2]}
  }
  
  re='([0-9]+)x([0-9]+)\+([0-9-]+)\+([0-9-]+)'

  if [[ $trg_geo =~ $re ]]; then

    float_as="floating enable"

    w=${BASH_REMATCH[1]} h=${BASH_REMATCH[2]}
    x=${BASH_REMATCH[3]} y=${BASH_REMATCH[4]}

    float_as+=", resize set $w $h"
    float_as+=", move position $x $y"
  else
    float_as="floating disable"
  fi

  messy "[con_id=${i3list[AWC]}]"    \
        floating enable,             \
        move --no-auto-back-and-forth to workspace "$trg_ws", \
        "$float_as" ,                \
        workspace --no-auto-back-and-forth "$trg_ws"

  i3var set "zen${i3list[AWC]}"

  [[ $float_as = "floating disable" ]] \
    && tile_with_i3king
}
