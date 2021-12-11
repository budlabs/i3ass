#!/bin/bash

cleanup() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"

  [[ -n $_msgstring ]] && i3-msg "${_qflag:-}" "$_msgstring"
}
