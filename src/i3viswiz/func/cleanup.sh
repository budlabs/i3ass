#!/bin/bash

cleanup() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"

  local qflag

  ((_o[verbose])) || qflag='-q'

  [[ -n $_msgstring ]] \
    && >&2 i3-msg "${qflag:-}" "$_msgstring"
}
