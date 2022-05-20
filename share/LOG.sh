#!/bin/bash #bashbud

[[ $BASHBUD_LOG ]] && {
  [[ -f $BASHBUD_LOG ]] || mkdir -p "${BASHBUD_LOG%/*}"
  exec 2>> "$BASHBUD_LOG"
}
