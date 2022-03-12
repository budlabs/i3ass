#!/bin/bash

float_toggle(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"

  local target

  # AWF - 1 = floating; 0 = tiled
  if ((i3list[AWF]==1)); then

    [[ -f $I3_KING_PID_FILE ]] && {
      ERM "hhh"

      mapfile -t king_commands <<< "$(i3king --conid "${i3list[TWC]}" --print-commands)"

      for command in "${!king_commands[@]}"; do
        if [[ ${king_commands[command]} =~ floating\ enable ]]
          then unset 'king_commands[command]'
          else messy "${king_commands[command]}"
        fi
      done

      [[ ${king_commands[*]} ]] && return
    }

    # WSA != i3fyra && normal tiling
    if [[ ${i3list[WAN]} != "${i3list[WFN]}" ]]; then
      messy "[con_id=${i3list[AWC]}]" floating disable
      return
    fi
    

    if [[ ${i3list[LVI]} =~ I3FYRA_MAIN_CONTAINER ]]; then
      target=$I3FYRA_MAIN_CONTAINER
    elif [[ ${i3list[LVI]} ]]; then
      target=${i3list[LVI]:0:1}
    elif [[ ${i3list[LHI]} ]]; then
      target=${i3list[LHI]:0:1}
    else
      target=$I3FYRA_MAIN_CONTAINER
    fi

     if [[ ${i3list[LEX]} =~ $target ]]; then
      container_show "$target"
      messy "[con_id=${i3list[AWC]}]" floating disable, \
        move to mark "i34${target}"
    else
      # if $target container doesn't exist, create it
      container_show "$target"
    fi
  else
    # AWF == 0 && make AWC floating
    messy "[con_id=${i3list[AWC]}]" floating enable
  fi
}
