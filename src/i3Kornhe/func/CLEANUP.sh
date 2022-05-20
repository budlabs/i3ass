#!/bin/bash

CLEANUP() {
  
  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"
  
  [[ -n $_msgstring ]] && {
    ((_o[verbose])) || qflag='-q'
    >&2 i3-msg "${qflag:-}" "$_msgstring"
  }

  ((___t)) && >&2 echo "<<< $___cmd" "$(( (10#${EPOCHREALTIME//[!0-9]} - ___t) / 1000 ))ms" #bashbud
}
