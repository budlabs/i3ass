#!/bin/bash

sendtomouse(){
  declare -i X Y newy newx tmpx tmpy breakx breaky

  eval "$(i3list "${_criteria[@]}")"

  messy "[con_id=${i3list[TWC]}]" focus

  ((i3list[TWF])) && {
    breaky=$((i3list[WAH]-(I3RUN_BOTTOM_GAP+i3list[TWH])))
    breakx=$((i3list[WAW]-(I3RUN_RIGHT_GAP+i3list[TWW])))

    eval "$(xdotool getmouselocation --shell)"

    tmpy=$((Y-(i3list[TWH]/2)))
    tmpx=$((X-(i3list[TWW]/2))) 

    ((Y>(i3list[WAH]/2))) \
      && newy=$((tmpy>breaky
              ? breaky
              : tmpy)) \
      || newy=$((tmpy<I3RUN_TOP_GAP
              ? I3RUN_TOP_GAP
              : tmpy))

    ((X<(i3list[WAW]/2))) \
      && newx=$((tmpx<I3RUN_LEFT_GAP 
              ? I3RUN_LEFT_GAP 
              : tmpx)) \
      || newx=$((tmpx>breakx
              ? breakx 
              : tmpx))

    messy "[con_id=${i3list[TWC]}]" \
      move absolute position $newx $newy
  }
}
