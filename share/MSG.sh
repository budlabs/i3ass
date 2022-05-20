#!/bin/bash

declare -g _msgstring

messy() {
  # arguments are valid i3-msg arguments
  (( _o[verbose] || BASHBUD_VERBOSE)) && ERM "m $*"
  (( _o[dryrun]  )) || _msgstring+="$*;"
}
