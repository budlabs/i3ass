#!/bin/env bash

focuswindow(){

  declare -i forcing
  local hvar

  forcing=$((_o[FORCE] ? 2 : _o[force] ? 1 : 0))
  
  # if target window is active, 
  if ((i3list[AWC] == i3list[TWC])); then
    
    # send it to the scratchpad
    if ((!_o[nohide])); then
      if [[ -z ${i3list[TWP]} ]]; then
        # keep floating state in a var
        messy "[con_id=${i3list[TWC]}]" floating enable, move scratchpad
        i3var set "hidden${i3list[TWC]}" "${i3list[TWF]}"
      else
        # if it is handled by i3fyra and active
        # hide the container
        ((_o[verbose])) && ERM "i3run -> i3fyra --force --hide ${i3list[TWP]}"
        i3fyra "${_o[verbose]:+--verbose}" --array "$_array" --force --hide "${i3list[TWP]}"
      fi

     ((forcing == 2)) && [[ $_command ]] && run_command

    else

     ((forcing > 0)) && [[ $_command ]] && run_command
    fi

  else # focus target window.
    # hvar can contain floating state of target
    hvar=$(i3var get "hidden${i3list[TWC]}")
    if [[ -n $hvar ]]; then
      # windows need to be floating on scratchpad
      # so to "restore" a tiling window we do this
      ((hvar == 1)) && fs=enable || fs=disable
      # clear the variable
      i3var set "hidden${i3list[TWC]}"
    else
      ((i3list[TWF] == 1)) && fs=enable || fs=disable
    fi
    
    if [[ -z ${i3list[TWP]} && ${i3list[WAN]} != "${i3list[WTN]}" ]]; then
      # target is not handled by i3fyra and not active
      # TWP - target window parent container name
      # target is not on active workspace
      if [[ ${i3list[WTN]} = __i3_scratch || ${_o[summon]} ]]; then
        ERM here we are
        messy "[con_id=${i3list[TWC]}]"   \
          move to workspace "${i3list[WAN]}", \
          floating $fs
          ((i3list[TWF] && _o[mouse])) && sendtomouse
      else
        messy workspace "${i3list[WTN]}"
      fi
        
    elif [[ ${i3list[WAN]} != "${i3list[WTN]}" ]]; then
      # window is handled by i3fyra and not active
      # current ws is i3fyra WS
      if ((i3list[WSF] == i3list[WSA])); then
        # target window is in a hidden (LHI) container
        [[ ${i3list[TWP]} =~ [${i3list[LHI]}] ]] && {
          ((_o[verbose])) && ERM "i3run -> i3fyra --force --show ${i3list[TWP]}"
          i3fyra "${_o[verbose]:+--verbose}" --array "$_array" --force --show "${i3list[TWP]}"
        }

      else # current ws is not i3fyra WS
        # WST == -1 , target window is on scratchpad
        if [[ ${i3list[WTN]} = __i3_scratch || ${_o[summon]} ]]; then

          messy "[con_id=${i3list[TWC]}]"           \
                move to workspace "${i3list[WAN]}", \
                floating $fs

          ((hvar && _o[mouse])) && sendtomouse
        else # got to target windows workspace
          # WTN == name (string) of workspace
          messy workspace "${i3list[WTN]}"
        fi
      fi
    fi

    messy "[con_id=${i3list[TWC]}]" focus

   ((forcing > 0)) && [[ $_command ]] && run_command
  fi

  echo "${i3list[TWC]}"
}
