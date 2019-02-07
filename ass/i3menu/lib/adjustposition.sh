#!/usr/bin/env bash

adjustposition() {
  local newy newx

  declare -A __menu

  eval "$(xdotool search --sync --classname rofi getwindowgeometry --shell | \
    awk -v FS='=' '{
      printf("__menu[%s]=%s\n",$1,$2)
    }'
  )"

  if ((__menu[X]<i3list[WAX])); then
    newx="${i3list[WAX]}"
  elif (((__menu[X]+__menu[WIDTH])>i3list[WAW])); then
    newx="$((i3list[WAW]-__menu[WIDTH]))"
  else
    newx=${__menu[X]}
  fi

  if ((__menu[Y]<i3list[WAY])); then
    newy="${i3list[WAY]}"
  elif (((__menu[Y]+__menu[HEIGHT])>i3list[WAH])); then
    newy="$((i3list[WAH]-__menu[HEIGHT]))"
  else
    newy=${__menu[Y]}
  fi

  xdotool windowmove "${__menu[WINDOW]}" "$newx" "$newy"
}
