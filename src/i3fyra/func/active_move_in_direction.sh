#!/bin/bash

move_normal() {
  local ldir

  case "${1:0:1}" in
    l ) ldir=left  ;;
    d ) ldir=down  ;;
    u ) ldir=up    ;;
    r ) ldir=right ;;
  esac

  messy "[con_id=${i3list[TWC]}]" move "$ldir"
}

active_move_in_direction() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local direction=$1

  ((i3list[TWF])) || [[ ${i3list[WTN]} != "${i3list[WFN]}" ]] \
    && exec i3Kornhe --array "$_array" m "$direction"

  # get visible info from i3viswiz
  # vw_target is the container currently at target pos
  # vw_parent is the parent of vw_target (A|B|C|D)
  # vw_groupsize is the number of siblings to the
  #   currently focused container
  # vw_wall is not none if target focus lands outside
  #   the current workspace
  local vw_wall vw_parent wizoutput
  declare -i vw_groupsize vw_target

  if [[ ${_o[dryrun]} ]]; then
    wizoutput=${i3list[VISWIZ]:=vw_target=3333 vw_wall=up vw_parent=C vw_groupsize=1}
    eval "$wizoutput"
  else
    read -r vw_wall vw_groupsize vw_target vw_parent < <(
      i3viswiz --parent=LIST  \
               --debug "wall,groupsize,trgcon,trgpar" \
               --debug-format "%v " "$direction"
    )

  fi

  ((_o[verbose])) && ERM "w "                         \
                         "vw_target=$vw_target "      \
                         "vw_wall=$vw_wall "          \
                         "vw_parent=$vw_parent "      \
                         "vw_groupsize=$vw_groupsize" \

  declare -A swapon

  swapon=([u]=AB [d]=CD [l]=AC [r]=BD)

  local sibdir target family sibling relatives

  ((_isvertical)) && sibdir=lr || sibdir=ud
    
  target=${i3list[TWP]}
  family=${i3list[TFF]}
  sibling=${i3list[TFS]}
  relatives=${i3list[TFO]}

  if   [[ ! ${i3list[TWP]} =~ [ABCD] ]]; then
    # when triggered on a tiled window on the i3fyra ws
    # that for some reason isn't part of the layout
    move_normal "$direction"
  elif [[ $vw_wall != none ]]; then # hit wall, toggle something

    if [[ $sibdir =~ $direction ]]; then # sibling toggling
      
      if [[ ${i3list[LVI]} =~ $sibling ]]; then
        container_hide "$sibling"
      elif [[ ${i3list[LHI]} =~ $sibling ]]; then
        container_show "$sibling"
        [[ ${swapon[$direction]} =~ $sibling ]] \
          && swap_move "i34$sibling" "i34$target"
      elif ((vw_groupsize > 1)); then # sibling doesn't exist
        active_move_to_container "$sibling"
        [[ ${swapon[$direction]} =~ $sibling ]] \
          || swap_move "i34$sibling" "i34$target"
        messy "[con_id=${i3list[TWC]}]" focus
      fi
    
    else # family toggling

      if [[ ${i3list[LVI]} =~ [${relatives}] ]]; then
        family_hide "$relatives"
      elif [[ ${i3list[LHI]} =~ [${relatives}] ]]; then
        family_show "$relatives"
        [[ ${swapon[$direction]} =~ [${relatives}] ]] \
          && swap_move "i34X$relatives" "i34X$family"
      elif ((vw_groupsize > 1)); then # no other family exist
        active_move_to_container "${relatives:0:1}"

        # hor: AC    vert: AB
        [[ $direction =~ u|l && $relatives = "${ori[fam2]}" ]] \
          && swap_move "i34X$relatives" "i34X$family"

        messy "[con_id=${i3list[TWC]}]" focus
      fi
    fi

  elif [[ $vw_parent = "$target" ]]; then
    # target and current container is the same
    # which indicates it is also not in a tabbed|stacked
    # container -> move normally
    move_normal "$direction"
  else

    if [[ ${i3list[C${vw_parent}L]} =~ splitv|splith && $direction =~ r|d ]]; then
      
      # move above/to the left of target container
      messy "[con_id=${vw_target}]" \
        mark --add i34tmp
      messy "[con_id=${i3list[TWC]}]" \
        move to mark i34tmp, swap mark i34tmp
      messy "[con_id=${vw_target}]" \
        mark --add --toggle i34tmp

    else 
      messy "[con_id=${i3list[TWC]}]" \
        move to mark "i34${vw_parent}", focus
    fi
  fi
  
}
