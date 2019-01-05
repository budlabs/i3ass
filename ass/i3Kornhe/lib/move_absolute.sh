#!/usr/bin/env bash

move_absolute(){
  local dir xpos ypos
  dir=$__lastarg

  ypos=$((
    dir<4 ? i3list[WAY]+__border_top :
    dir<7 ? i3list[WAY]+(i3list[WAH]/2)-(i3list[AWH]/2) 
          : i3list[WAY]+(i3list[WAH]-(i3list[AWH]+__border_bot))
  ))
  
  xpos=$((
    (dir==1||dir==4||dir==7) ? i3list[WAX]+__border_left :         
    (dir==2||dir==5||dir==8) ? i3list[WAX]+(i3list[WAW]/2-(i3list[AWW]/2))
    : i3list[WAX]+(i3list[WAW]-(i3list[AWW]+__border_right))         
  ))

  i3-msg -q "[con_id=${i3list[AWC]}]" move absolute position $xpos $ypos
  __title="MOVE"
  set_tf
  exit
}
