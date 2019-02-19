#!/usr/bin/env bash

launchcommand(){

  [[ -z ${__o[command]:-} ]] && exit 1
  
  eval "${__o[command]}" > /dev/null 2>&1 &

  [[ -n ${__o[rename]} ]] && {

    [[ ${acri[0]} = '-c' ]] && xdtopt=("--class")
    [[ ${acri[0]} = '-i' ]] && xdtopt=("--classname")
    [[ ${acri[0]} = '-t' ]] && xdtopt=("--name")

    xdtopt+=("${acri[1]}")

    xdotool set_window "${xdtopt[@]}" "$(i3get "${acri[0]}" "${__o[rename]}" -r d -y)"
  }

  i3list[TWC]=$(i3get -y "${acri[@]}")
  
  ((i3list[TWF] == 1)) && ((${__o[mouse]:-0} == 1)) && {
    eval "$(i3list "${acri[@]}")"
    sendtomouse
  }

  sleep .2
  i3-msg -q "[con_id=${i3list[TWC]}]" focus
  echo "${i3list[TWC]}"
}
