#!/usr/bin/env bash

set_tf(){
  local tf

  eval "$(i3list)"

  tf="$(
    printf '%s w:%s h:%s x:%s y:%s' \
      "$__title" "${i3list[AWW]}" "${i3list[AWH]}" \
      "${i3list[AWX]}" "${i3list[AWY]}"
  )"

  i3-msg -q "[con_id=${i3list[AWC]}]" title_format "${tf}"
}

current_tf(){
  local curtf

  curtf="$(i3get -r o)"
  [[ ! ${curtf:-} =~ ^\"*(MOVE|SIZE) ]] && {
    i3var set sizetits "$curtf"
  }
}
