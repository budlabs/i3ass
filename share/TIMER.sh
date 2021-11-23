#!/bin/bash

timer() {
  local action=$1 name=$2
  declare -g ___t

  if [[ $action = start ]]; then
    ___t=$(( 10#${EPOCHREALTIME//[!0-9]} ))
    ERM "$name START"
    ERM "==========="
  else
    ERM "======================"
    ERM "$name STOP -" \
        "$(( (10#${EPOCHREALTIME//[!0-9]} - ___t) / 1000 ))ms"
    ERM "======================"
  fi
}
