#!/bin/bash

orientation() {

  local new_orientation=$1 
  local old_orientation=${i3list[ORI]}
  local i container

  [[ $new_orientation = "$old_orientation" ]] && return

  declare -A new_ori
  declare -a in_the_wrong

  [[ $new_orientation = vertical ]] \
    && new_ori=(
                  [main]=AC [fam1]=AB [fam2]=CD 
                  [lo_main]=splitv [lo_fam]=splith 
                  [C_to]=CD [B_to]=AB [C_from]=BD [B_from]=AC
                ) \
    || new_ori=(
                  [main]=AB [fam1]=AC [fam2]=BD 
                  [lo_main]=splith [lo_fam]=splitv 
                  [C_to]=AC [B_to]=BD [C_from]=AB [B_from]=CD
                )

  # ori array is defined in initialize_globals
  # and have the old orientation details
  [[ ${i3list[N"${ori[main]}"]} ]] \
    && messy "[con_mark=i34X${ori[main]}] mark i34MAIN"

  [[ ${i3list[N"${ori[fam1]}"]} ]]         \
    && messy "[con_mark=i34X${ori[fam1]}]" \
       layout "${new_ori[lo_main]}",       \
       mark "i34X${new_ori[fam1]}"

  [[ ${i3list[N"${ori[fam2]}"]} ]]         \
    && messy "[con_mark=i34X${ori[fam2]}]" \
       layout "${new_ori[lo_main]}",       \
       mark "i34X${new_ori[fam2]}"

  [[ ${i3list[LEX]} =~ B ]] \
    && [[ ${i3list[N${new_ori[B_from]}]} = "${i3list[CBN]}" ]] \
    && in_the_wrong[i++]=B
    
  [[ ${i3list[LEX]} =~ C ]] \
    && [[ ${i3list[N${new_ori[C_from]}]} = "${i3list[CCN]}" ]] \
    && in_the_wrong[i]=C

  if ((${#in_the_wrong[@]} == 2)); then
    messy "[con_mark=i34B]" swap mark i34C
  elif ((${#in_the_wrong[@]} == 1)); then
    container=${in_the_wrong[0]}
    messy "[con_mark=i34${container}]" \
          "move to mark i34X${new_ori[${container}_to]}"
  fi

  [[ $new_orientation = vertical && ${in_the_wrong[*]} =~ C ]] \
    && messy "[con_mark=i34C] swap mark i34${new_ori[C_to]/C}"

  [[ $new_orientation = horizontal && ${in_the_wrong[*]} =~ B ]] \
    && messy "[con_mark=i34B] swap mark i34${new_ori[B_to]/B}"

  # test below is true if f.i orientation WAS h and only AC
  # is visible. If BD is on the scratchpad, it
  # will now be renamed (CD), but CD needs to be on this
  # ws with C innit.
  [[ ! ${in_the_wrong[*]} && ${i3list[LVI]} =~ ([BC]) ]] && {
    container=${BASH_REMATCH[1]}
    [[ ${i3list[N"${new_ori[${container}_from]}"]} ]] \
      && messy "[con_mark=i34X${new_ori[${container}_to]}]" unmark
    messy "[con_mark=i34${container}]"      \
          "move to mark i34MAIN", split "${new_ori[lo_main]: -1}",  \
          focus, focus parent
    messy mark "i34X${new_ori[${container}_to]}"
  }

  for cont in A B C D; do
    [[ ${i3list[LVI]} =~ $cont ]] || continue
    messy "[con_mark=i34$cont] layout ${new_ori[lo_fam]}"
  done
  
  messy "[con_mark=i34MAIN] mark i34X${new_ori[main]}"

  i3var set i34ORI "$new_orientation"
}
