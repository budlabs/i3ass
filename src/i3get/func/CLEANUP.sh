#!/bin/bash #bashbud

trap 'CLEANUP' EXIT INT HUP

CLEANUP() {
  
  ((___t)) && >&2 echo "<<< $___cmd" "$(( (10#${EPOCHREALTIME//[!0-9]} - ___t) / 1000 ))ms" #bashbud
}
