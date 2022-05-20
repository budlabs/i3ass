#!/bin/bash

trap 'CLEANUP' EXIT INT HUP

CLEANUP() {
  
  [[ -n $_msgstring ]] && {
    ((_o[verbose])) || qflag='-q'
    >&2 i3-msg "${qflag:-}" "$_msgstring"
  }

  ((___t)) && >&2 echo "<<< $___cmd" "$(( (10#${EPOCHREALTIME//[!0-9]} - ___t) / 1000 ))ms" #bashbud
}
