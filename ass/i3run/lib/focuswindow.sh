#!/bin/env bash

focuswindow(){
  
  # if target window is active (current), 
  # send it to the scratchpad
  if [[ ${i3list[AWC]} = "${i3list[TWC]}" ]]; then
    
    if ((${__o[nohide]:-0}!=1)); then

      if [[ -z ${i3list[TWP]} ]]; then
        # keep floating state in a var
        i3var set "hidden${i3list[TWC]}" "${i3list[TWF]}"
        i3-msg -q "[con_id=${i3list[TWC]}]" move scratchpad
      else
        # if it is handled by i3fyra and active
        # hide the container
        i3fyra -z "${i3list[TWP]}"
      fi
    fi
  # else focus target window.
  else
    : "${hvar:=$(i3var get "hidden${i3list[TWC]}")}"
    if [[ -n $hvar ]]; then
      ((hvar == 1)) && fs=enable || fs=disable
      # clear the variable
      i3var set "hidden${i3list[TWC]}"
    else
      ((i3list[TWF] == 1)) && fs=enable || fs=disable
    fi
    # window is not handled by i3fyra and not active
    if [[ -z ${i3list[TWP]} ]]; then
      if [[ ${i3list[WSA]} != "${i3list[WST]}" ]]; then
        if [[ ${i3list[WST]} = "-1" ]] || ((${__o[summon]:-0}==1)); then
          i3-msg -q "[con_id=${i3list[TWC]}]" \
            move to workspace "${i3list[WAN]}", \
            floating $fs
            i3-msg -q "[con_id=${i3list[TWC]}]" focus
            ((i3list[TWF] == 1)) && ((${__o[mouse]:-0}==1)) \
              && sendtomouse
        else
          i3-msg -q workspace "${i3list[WTN]}"
        fi
        
      fi
    else
      # window is handled by i3fyra and not active
      if [[ ${i3list[WSA]} != "${i3list[WST]}" ]]; then
        # window is not on current ws
        if [[ ${i3list[WSF]} = "${i3list[WSA]}" ]]; then
          # current ws is i3fyra WS
          [[ ${i3list[TWP]} =~ [${i3list[LHI]}] ]] \
            && i3fyra -s "${i3list[TWP]}"
        else
          # current ws is not i3fyra WS
          if [[ ${i3list[WST]} = "-1" ]] || ((${__o[summon]:-0}==1)); then
            i3-msg -q "[con_id=${i3list[TWC]}]" \
              move to workspace "${i3list[WAN]}", floating $fs
              i3-msg -q "[con_id=${i3list[TWC]}]" focus
              ((i3list[TWF] == 1)) && ((${__o[mouse]:-0}==1)) \
                && sendtomouse
          else
            i3-msg -q workspace "${i3list[WTN]}"
          fi
        fi
      fi
    fi
    i3-msg -q "[con_id=${i3list[TWC]}]" focus
  fi

  echo "${i3list[TWC]}"
}
