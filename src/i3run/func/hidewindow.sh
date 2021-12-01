#!/bin/bash

hidewindow() {
  # send it to the scratchpad
  if ((!_o[nohide])); then
    if [[ -z ${i3list[TWP]} ]]; then
      # keep floating state in a var
      messy "[con_id=${i3list[TWC]}]" floating enable, move scratchpad
      i3var set "hidden${i3list[TWC]}" "${i3list[TWF]}"
    else
      # if it is handled by i3fyra and active
      # hide the container
      ((_o[verbose])) && ERM "i3run -> i3fyra --force --hide ${i3list[TWP]}"
      i3fyra "${_o[verbose]:+--verbose}" --array "$_array" --force --hide "${i3list[TWP]}"
    fi

   ((_o[FORCE])) && [[ $_command ]] && run_command

  else

   ((_o[force] + _o[FORCE] > 0)) && [[ $_command ]] && run_command
  fi
}
