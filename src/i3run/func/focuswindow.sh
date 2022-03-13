#!/bin/bash

focuswindow(){

  local hvar target_container
  
  # if target window is active, 
  if ((i3list[AWC] == i3list[TWC])); then
    hidewindow
  elif [[ ${_o[hide]} ]]; then
    [[ ${i3list[WTN]} != __i3_scratch ]] && hidewindow
    return
  else # focus target window.
  
    # prioritize visible containers
    if [[ ${_o[conid]} || ${_o[winid]} ]]; then
      target_container=${i3list[AWC]}
    elif [[ ${i3list[WTN]} = __i3_scratch ]]; then 
      target_container=$(i3viswiz --scratchpad "${_criteria[@]}")
    elif [[ ${i3list[WTN]} = "${i3list[WAN]}" ]]; then
      target_container=$(i3viswiz "${_criteria[@]}")
    fi
    
    : "${target_container:=${i3list[TWC]}}"

    # hvar can contain floating state of target
    hvar=$(i3var get "hidden${target_container}")
    if [[ -n $hvar ]]; then
      # windows need to be floating on scratchpad
      # so to "restore" a tiling window we do this
      ((hvar == 1)) && fs=enable || fs=disable
      # clear the variable
      i3var set "hidden${target_container}"
    else
      ((i3list[TWF] == 1)) && fs=enable || fs=disable
    fi
    
    if [[ -z ${i3list[TWP]} && ${i3list[WAN]} != "${i3list[WTN]}" ]]; then
      # target is not handled by i3fyra and not active
      # TWP - target window parent container name
      # target is not on active workspace
      if [[ ${i3list[WTN]} = __i3_scratch || ${_o[summon]} ]]; then
        messy "[con_id=${target_container}]"           \
              move --no-auto-back-and-forth to workspace "${i3list[WAN]}", \
              floating "$fs"
          ((i3list[TWF] && _o[mouse])) && sendtomouse
      else
        messy workspace --no-auto-back-and-forth "${i3list[WTN]}"
      fi
        
    elif [[ ${i3list[WAN]} != "${i3list[WTN]}" ]]; then
      # window is handled by i3fyra and not active
      if [[ ${i3list[WFN]} = "${i3list[WAN]}" ]]; then # current ws is i3fyra WS
        # target window is in a hidden (LHI) container
        [[ ${i3list[TWP]} =~ [${i3list[LHI]}] ]] && {
          ((_o[verbose])) && ERM "i3run -> i3fyra --force --show ${i3list[TWP]}"
          i3fyra "${_o[verbose]:+--verbose}" --array "$_array" --force --show "${i3list[TWP]}"
        }

      else # current ws is not i3fyra WS
        # WST == -1 , target window is on scratchpad
        if [[ ${i3list[WTN]} = __i3_scratch || ${_o[summon]} ]]; then

          messy "[con_id=${target_container}]"           \
                move --no-auto-back-and-forth to workspace "${i3list[WAN]}", \
                floating $fs

          ((hvar && _o[mouse])) && sendtomouse
        else # got to target windows workspace
          # WTN == name (string) of workspace
          messy workspace --no-auto-back-and-forth "${i3list[WTN]}"
        fi
      fi
    fi

    messy "[con_id=${target_container}]" focus

   ((_o[force] + _o[FORCE] > 0)) && [[ $_command ]] && run_command
  fi

  echo "${target_container}"
}
