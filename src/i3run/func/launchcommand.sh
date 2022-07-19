#!/bin/bash

launchcommand(){

  local winid conid k l
  declare -a xdtopt

  [[ $_command ]] || ERX i3run no command, no action
  
  run_command

  if   [[ -n ${_o[rename]} ]]; then

    [[ ${_criteria[0]} = '--class'    ]] && xdtopt=("--class")
    [[ ${_criteria[0]} = '--instance' ]] && xdtopt=("--classname")
    [[ ${_criteria[0]} = '--title   ' ]] && xdtopt=("--name")

    xdtopt+=("${_criteria[1]}")
    _criteria[1]=${_o[rename]}

  elif [[ -n "${_o[rename-title]}${_o[rename-class]}${_o[rename-instance]}" ]]; then

    for k in title class instance ; do

      [[ ${_o[rename-$k]} ]] || continue
      
      case "$k" in
        title    ) xdtopt+=(--name "${_o[$k]}")      ;;
        class    ) xdtopt+=(--class "${_o[$k]}")     ;;
        instance ) xdtopt+=(--classname "${_o[$k]}") ;;
      esac

      # when renaming, replace the criteria arg (--? + 1)
      # with the argument to the replace (OLD_NAME)
      for l in "${!_criteria[@]}"; do
        [[ ${_criteria[$l]} = --$k ]] && {
          _criteria[l+1]=${_o[rename-$k]} 
          break
        }
      done

    done

  fi

  [[ -n "${xdtopt[*]}" ]] && {

    read -rs winid conid \
      <<< "$(i3get "${_criteria[@]}" -yr dn --print-format '%v ')"

    ((_o[verbose])) \
      && ERM "i3run -> xdotool set_window ${xdtopt[*]} $winid"
      
    xdotool \
      set_window "${xdtopt[@]}" "$winid"       \
      set_window --overrideredirect 1 "$winid" \
      set_window --overrideredirect 0 "$winid" \
      windowunmap "$winid"                     \
      windowmap   "$winid"                           

    # need to re-get conid here because a the window
    # gets a new conid when we --overrideredirect
    conid=$(i3get -d "$winid")
  }
  
  : "${conid:=$(i3get -y "${_criteria[@]}")}"
  
  ((_o[mouse])) && sendtomouse

  messy "[con_id=$conid]" focus
  ((_o[silent])) || echo "$conid"
}
