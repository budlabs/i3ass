#!/usr/bin/env bash

main(){
  local cmd target

  if [[ -n ${__o[show]:-} ]]; then
    cmd=containershow
    target="${__o[show]}"
  elif [[ -n ${__o[hide]:-} ]]; then
    cmd=containerhide
    target="${__o[hide]}"
  elif [[ -n ${__o[layout]:-} ]]; then
    cmd=applysplits
    target="${__o[layout]}"
  elif ((${__o[float]:-0}==1)); then
    cmd=togglefloat
  elif [[ -n ${__o[move]:-} ]]; then
    cmd=windowmove
    target="${__o[move]}"
  fi

  declare -A i3list # globals array
  eval "$(i3list ${__o[target]:-})"

  [[ -z ${i3list[WSF]} ]] \
    && i3list[WSF]=${I3FYRA_WS:-${i3list[WSA]}}

  i3list[CMA]=${I3FYRA_MAIN_CONTAINER:-A}

  ${cmd} "${target:-}" # run command

  [[ $cmd = windowmove ]] && [[ -z ${i3list[SIBFOC]} ]] \
      && i3-msg -q "[con_id=${i3list[AWC]}]" focus

  [[ $cmd = togglefloat ]] \
      && i3-msg -q "[con_id=${i3list[AWC]}]" focus

  [[ -n ${i3list[SIBFOC]:-} ]] \
    && i3-msg -q "[con_mark=i34${i3list[SIBFOC]}]" focus child
  
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
