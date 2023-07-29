#!/bin/bash

create_zen_workspace() {

  local ws_zen width height x y

  [[ ${_o[workspace]} ]] \
    && ws_zen=${_o[workspace]}          \
    || ws_zen=$(next_vacant_workspace)

  messy "[con_id=${i3list[AWC]}]"    \
        move --no-auto-back-and-forth to workspace "$ws_zen," \
        floating disable,            \
        split v, layout tabbed,      \
        focus, focus parent

  messy "mark $_mark"

  ((_o[width]  > 0 && _o[width]  < 100)) || _o[width]=75
  ((_o[height] > 0 && _o[height] < 100)) || _o[height]=90

  width=$((  (i3list[WAW] * _o[width])  / 100 ))
  height=$(( (i3list[WAH] * _o[height]) / 100 ))

  ((_o[xpos] < 0)) && _o[xpos]=$(( i3list[WAW]-(width  - _o[xpos]) ))
  ((_o[ypos] < 0)) && _o[ypos]=$(( i3list[WAH]-(height - _o[ypos]) ))

  x=${_o[xpos]:-$(( (i3list[WAW]-width)  / 2 ))}
  y=${_o[ypos]:-$(( (i3list[WAH]-height) / 2 ))}

  x=$((x + i3list[WAX])) y=$((y + i3list[WAY]))

  messy "[con_mark=$_mark]" \
        floating enable,    \
        workspace --no-auto-back-and-forth "$ws_zen"

  # if the focus action below isn't included, the
  # container will not resize properly..
  messy "[con_id=${i3list[AWC]}] focus"

  messy "[con_mark=$_mark]"           \
        "resize set $width $height ," \
        "move absolute position $x $y"

  [[ $_var_zen_current ]] \
    || i3var set "zen${i3list[AWC]}" "$_var_zen_new"
}
