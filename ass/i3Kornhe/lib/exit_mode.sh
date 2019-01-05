#!/usr/bin/env bash

exit_mode(){
  local tits

  i3var set sizemode
  i3-msg -q mode "default"
  tits="$(i3var get sizetits)"



  [[ -n ${tits:-} ]] \
    && tits="${tits//\\}" \
    || tits='%title'

  sizecon="$(i3var get sizecon)"

  i3var set sizetits
  i3var set sizecon

  i3-msg -q "[con_id=$sizecon]" title_format "${tits}"
  exit
}
