#!/bin/bash

launchcommand(){

  local winid conid k l
  declare -a xdtopt

  if [[ $_command ]]
    then run_command
    else ERX i3run no command, no action
  fi

  if   [[ -n ${_o[rename]} ]]; then

    [[ ${acri[0]} = '--class'    ]] && xdtopt=("--class")
    [[ ${acri[0]} = '--instance' ]] && xdtopt=("--classname")
    [[ ${acri[0]} = '--title   ' ]] && xdtopt=("--name")

    xdtopt+=("${acri[1]}")
    acri[1]=${_o[rename]}

  elif [[ -n "${_o[rename-title]}${_o[rename-class]}${_o[rename-instance]}" ]]; then

    for k in title class instance ; do
      [[ ${_o[rename-$k]} ]] && {
        case "$k" in
          title    ) xdtopt+=(--name "${_o[$k]}")      ;;
          class    ) xdtopt+=(--class "${_o[$k]}")     ;;
          instance ) xdtopt+=(--classname "${_o[$k]}") ;;
        esac

        # when renaming, replace the criteria arg (--? + 1)
        # with the argument to the replace (OLD_NAME)
        for l in "${!acri[@]}"; do
          [[ ${acri[$l]} = --$k ]] && {
            acri[l+1]=${_o[rename-$k]} 
            break
          }
        done
      }

    done

  fi

  [[ -n "${xdtopt[*]}" ]] && {

    read -rs winid conid \
      <<< "$(i3get "${acri[@]}" -yr dn --print-format '%v ')"

    ((_o[verbose])) \
      && ERM "i3run -> xdotool set_window ${xdtopt[*]} $winid"
      
    xdotool \
      set_window "${xdtopt[@]}" "$winid"       \
      set_window --overrideredirect 1 "$winid" \
      set_window --overrideredirect 0 "$winid" \
      windowunmap "$winid"                     \
      windowmap   "$winid"                           
  }
  
  : "${conid:=$(i3get -y "${acri[@]}")}"
  
  ((_o[mouse])) && sendtomouse

  messy "[con_id=$conid]" focus
  echo "$conid"
}
