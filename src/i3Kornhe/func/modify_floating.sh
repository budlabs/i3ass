#!/bin/sh

modify_floating() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"

  local corner cv ch conid

  conid=${last[conid]:=${i3list[AWC]}}

  # m - move
  if [[ $_next_mode = m ]]; then

    title_format="MOVE "

    case "$_direction" in
      l ) ((i3list[AWX]-=_speed)) ;;
      r ) ((i3list[AWX]+=_speed)) ;;
      u ) ((i3list[AWY]-=_speed)) ;;
      d ) ((i3list[AWY]+=_speed)) ;;
      1|2|3|4|5|6|7|8|9 )
        
        case "$_direction" in
          1|2|3 ) i3list[AWY]=$(( i3list[WAY]+_margin )) ;;
          4|5|6 ) i3list[AWY]=$(( i3list[WAY]+(i3list[WAH]/2)-(i3list[AWH]/2) )) ;;
          7|8|9 ) i3list[AWY]=$(( i3list[WAY]+( i3list[WAH]-(i3list[AWH]+_margin) ) )) ;;
        esac

        case "$_direction" in
          1|4|7 ) i3list[AWX]=$(( i3list[WAX]+_margin )) ;;
          2|5|8 ) i3list[AWX]=$(( i3list[WAX]+(i3list[WAW]/2)-(i3list[AWW]/2) )) ;;
          3|6|9 ) i3list[AWX]=$(( i3list[WAX]+( i3list[WAW]-(i3list[AWW]+_margin) ) )) ;;
        esac
      ;;

    esac

    corner=move
    messy "[con_id=$conid] move position ${i3list[AWX]} ${i3list[AWY]}"

  elif [[ $_next_mode = s ]]; then

    if [[ ${last[corner]} =~ ^b|t ]]; then
      corner=${last[corner]}
    else
      _speed=0
      case "$_direction" in
        l ) corner="topleft"     ;;
        r ) corner="bottomright" ;;
        u ) corner="topright"    ;;
        d ) corner="bottomleft"  ;;
      esac
    fi

    title_format="RESIZE $corner"

    [[ $corner =~ (top|bottom)(left|right) ]] \
      && cv=${BASH_REMATCH[1]} ch=${BASH_REMATCH[2]} 
      
    if   [[ $cv = top && $_direction = u ]]; then
      resize_as="grow up"
    elif [[ $cv = top && $_direction = d ]]; then
      resize_as="shrink up"
    elif [[ $cv = bottom && $_direction = u ]]; then
      resize_as="shrink down"
    elif [[ $cv = bottom && $_direction = d ]]; then
      resize_as="grow down"
    fi

    if   [[ $ch = left && $_direction = l ]]; then
      resize_as="grow left"
    elif [[ $ch = left && $_direction = r ]]; then
      resize_as="shrink left"
    elif [[ $ch = right && $_direction = l ]]; then
      resize_as="shrink right"
    elif [[ $ch = right && $_direction = r ]]; then
      resize_as="grow right"
    fi

    ((_speed)) && messy "[con_id=$conid] resize $resize_as $_speed px"

  fi

  last=(
        [mode]=$_next_mode
        [conid]=$conid
        [corner]=$corner
        [title]=${last[title]:-%title}
       )
}
