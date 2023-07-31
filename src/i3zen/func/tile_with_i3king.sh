#!/bin/bash

tile_with_i3king() {
  [[ -f $I3_KING_PID_FILE ]] && {

    ((_o[verbose])) && ERM "i3zen -> i3king --conid ${i3list[AWC]}"

    mapfile -t king_commands <<< "$(i3king --conid "${i3list[AWC]}" \
                                           --print-commands         \
                                           --json "$_json")"

    for command in "${!king_commands[@]}"; do
      if [[ ${king_commands[command]} =~ floating\ enable ]]
        then unset 'king_commands[command]'
        else messy "${king_commands[command]}"
      fi
    done
  }
}
