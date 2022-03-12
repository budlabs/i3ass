#!/usr/bin/env bash

adjustposition() {
  declare -i newy newx opty

  declare -A geo

  # xdotool --getwindowgeometry --shell ; example:
  # WINDOW=6291526
  # X=0
  # Y=43
  # WIDTH=1568
  # HEIGHT=171
  # SCREEN=0
  #
  # AWK turns the output from: WINDOW=.. -> geo[WINDOW]=...
  # before it's evaluated

  eval "$(xdotool search --sync --classname rofi getwindowgeometry --shell | \
    gawk '{printf("geo[%s]=%s\n",$1,$2)}' FS='='
  )"

  opty=$(( ${1:-0} <= -0 ? i3list[WAH]-( (opty*-1)+geo[HEIGHT] ) : $1 ))

  newy=$(( opty < i3list[WAY] ? i3list[WAY] 
         : opty+geo[HEIGHT] > i3list[WAH] ? i3list[WAH]-geo[HEIGHT] 
         : opty ))

  newx=$(( geo[X] < i3list[WAX] ? i3list[WAX] 
         : geo[X]+geo[WIDTH] > i3list[WAW] ? i3list[WAW]-geo[WIDTH] 
         : geo[X] ))

  xdotool windowmove "${geo[WINDOW]}" "$newx" "$newy"
}
