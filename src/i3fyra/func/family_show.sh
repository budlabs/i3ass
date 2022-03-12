#!/bin/bash

family_show() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"

  local target_family=$1 target_container=${2:-}
  local other_family

  [[ ${i3list["N${target_family}"]} = "${i3list[WFN]}" ]] \
    && return

  
  if [[ -z ${i3list[X${target_family}]} ]]; then
    # when family_hide and family contains only
    # one container. The family is destroyed and
    # the container is moved to the scratchpad
    # but noted in [F$family]
    last_in_fam=${i3list[F$target_family]:0:1}

    if [[ ! $target_container ]]; then
     [[ ${i3list[LEX]} =~ $last_in_fam ]] && {
       family_create "$target_family" "$last_in_fam"
     }
    else
      family_create "$target_family" "$target_container"
    fi

  elif [[ ${i3list["N${target_family}"]} != "${i3list[WFN]}" ]]; then

    messy "[con_mark=i34X${target_family}]" \
      move --no-auto-back-and-forth to workspace "${i3list[WFN]}", \
      floating disable

    if [[ ${i3list["X${ori[main]}"]} ]]; then

      messy "[con_mark=i34X${ori[main]}]"     \
        split "${ori[charmain]}"
      messy "[con_mark=i34X${target_family}]" \
        move to mark "i34X${ori[main]}"

    else
      messy "[con_mark=i34X${target_family}]" \
        layout split"${ori[charmain]}", \
        focus, focus parent
      messy mark "i34X${ori[main]}"
    fi
  fi

  # when target family is AC or AB, it is 
  # the "first" family in the main container
  # if the other family is visible, 
  # we need to swap them
  [[ $target_family =~ A ]] && {

    [[ ${ori[fam1]} =~ A ]] \
      && other_family=${ori[fam2]} \
      || other_family=${ori[fam1]}

    [[ ${i3list["N${other_family}"]} = "${i3list[WFN]}" ]] \
      && messy "[con_mark=i34X${target_family}]"  \
           swap mark "i34X${other_family}"
  }

  apply_splits "${ori[main]}=${i3list[M${ori[main]}]}"
}
