#!/bin/bash

initialize_globals() {

  declare -Ag i3list
  declare -Ag mark_vars
  declare -Ag new_size
  declare -Ag ori

  _marks_json=$(i3-msg -t get_marks)

  [[ ! $_action =~ orintation|layout && ! $_marks_json =~ i3fyra_ws ]] && {
    # the i3fyra_ws mark/var is read by i3list
    # if it isn't present no info regarding i3fyra
    # will be in the output of i3list
    # we set the mark/var here

    ((_o[verbose])) && ERM INIT FYRA_WS

    [[ $I3FYRA_WS ]] || {
      eval "$(i3list)"
      I3FYRA_WS=\"${i3list[WAN]}\"
    }

    (( _o[float] && i3list[AWF]==0 )) \
      || i3var set i3fyra_ws "$I3FYRA_WS"

  }

  [[ $_marks_json =~ i34ORI ]] || {

    ((_o[verbose])) && ERM INIT FYRA_ORIENTATION

    i3var set i34ORI "${_o[orientation]:-$I3FYRA_ORIENTATION}"
  }

  # _qflag is option added to i3-msg (cleanup())
  ((_o[verbose])) || _qflag='-q'

  : "${_o[array]:=$(i3list ${_o[conid]:+-n ${_o[conid]}})}"
  eval "${_array:=${_o[array]}}"

  declare -gi _isvertical

  declare -i sw=${i3list[WFW]:-${i3list[WAW]}}
  declare -i sh=${i3list[WFH]:-${i3list[WAH]}}
  declare -i swh=$((sw/2))
  declare -i shh=$((sh/2))

  if [[ ${i3list[ORI]} = vertical ]]; then
    _isvertical=1
    ori=(

      [main]=AC [fam1]=AB [fam2]=CD [fam3]=BD

      [charmain]=v        [charfam]=h
      [movemain]=down     [movefam]=right
      [resizemain]=height [resizefam]=width
      [sizemain]=$sh      [sizefam]=$sw 
      [sizemainhalf]=$shh [sizefamhalf]=$swh

    )
  else
    _isvertical=0
    ori=(

      [main]=AB [fam1]=AC [fam2]=BD [fam3]=CD

      [charmain]=h        [charfam]=v
      [movemain]=right    [movefam]=down
      [resizemain]=width  [resizefam]=height
      [sizemain]=$sw      [sizefam]=$sh
      [sizemainhalf]=$swh [sizefamhalf]=$shh

    )
  fi
}
