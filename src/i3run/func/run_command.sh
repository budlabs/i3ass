#!/bin/bash

run_command() {
  [[ ${_command[*]} ]] || return
  ((_o[verbose])) && ERM "i3run -> ${_command[*]}"
  
  nohup env "${_command[@]}"  > /dev/null 2>&1 &
}
