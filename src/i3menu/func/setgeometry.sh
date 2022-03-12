#!/usr/bin/env bash

defaultoffset(){
  __xpos=0
  __ypos=0
  _o[xoffset]=0
  _o[yoffset]=0
  __width=${i3list[WAW]}
  __height=20
  _o[layout]=default
  __orientation=horizontal
  __anchor=1
}

setgeometry(){

  __layout="$1"

  # default geometry
  : "${__xpos:=${_o[xpos]:-0}}"
  : "${__ypos:=${_o[ypos]:-0}}"
  : "${_o[xoffset]:=0}"
  : "${_o[yoffset]:=0}"
  : "${__width:=${_o[width]:-${i3list[WAW]}}}"
  : "${__height:=${_o[height]:-${i3list[TWB]:-20}}}"
  : "${_o[anchor]:=1}"
  : "${__orientation:=horizontal}"

  # if layout is window or container, but no list -> titlebar
  [[ $__layout =~ A|B|C|D|window && ! -f $_tmp_list_file ]] && {
    defaultoffset
    __layout=titlebar
  }

  # if layout is container but container is not visible -> default
  [[ $__layout =~ A|B|C|D ]] && [[ ! ${i3list[LVI]} =~ [${__layout}] ]] && {
    defaultoffset
    __layout=default
  }

  # if layout is window, tab or titlebar but no target window -> default
  [[ $__layout =~ window|tab|titlebar ]] && [[ -z ${i3list[TWC]} ]] && {
    defaultoffset
    __layout=default
  }

  case "$__layout" in

    titlebar  ) 
      __ypos=$((i3list[TWY]+i3list[WAY]))
      __xpos=$((i3list[TWX]+i3list[WAX]))
      __width=${i3list[TWW]}
      __height=${i3list[TWB]}
      __orientation=horizontal
    ;;

    window    )
        __xpos=$((i3list[TWX]+i3list[WAX]))
        __ypos=$((i3list[TWY]+i3list[WAY]))
        __width=${i3list[TWW]}
        __height=${i3list[TWH]}
        __orientation=vertical
        _o[orientation]=""
    ;;

    bottom )
      __ypos=$((i3list[WAH]-i3list[AWB]))
    ;;

    tab       ) 
      if ((i3list[TTW]==i3list[TWW])); then
        __xpos=$((i3list[TWX]+i3list[WAX]))
        __width=${i3list[TWW]}
      else
        __xpos=$((i3list[TTX]+i3list[TWX]))
        __width=${i3list[TTW]}
      fi
      __ypos=$((i3list[TWY]+i3list[WAY]))
      __height=${i3list[TWB]}
      __orientation=horizontal
    ;;

    A|B|C|D ) 
      case "$__layout" in
        A) 
          __xpos=0
          __ypos=0
          __width=${i3list[SAB]:-${i3list[WAW]}}
          __height=${i3list[SAC]:-${i3list[WAH]}}
        ;;

        B) 
          __xpos=${i3list[SAB]:-0}
          __ypos=0
          __width=$((i3list[WAW]-__xpos))
          __height=${i3list[SBD]:-${i3list[SAC]:-${i3list[WAH]}}}
        ;;

        C) 
          __xpos=0
          __ypos=${i3list[SAC]:-0}
          __width=${i3list[SCD]:-${i3list[SAB]:-${i3list[WAW]}}}
          __height=$((i3list[WAH]-__ypos))
        ;;

        D) 
          __xpos=${i3list[SCD]:-${i3list[SAB]:-0}}
          __ypos=${i3list[SBD]:-0}
          __width=$((i3list[WAW]-__xpos))
          __height=$((i3list[WAH]-__ypos))
        ;;
      esac

      ((__height))   || __height="${i3list[WAH]}"
      ((__width))    || __width="${i3list[WAW]}"
      __orientation=vertical
      _o[orientation]=""
    ;;

    mouse )

      < <(xdotool getmouselocation --shell \
         | sed -r 's/^.+=//g') read -rd '' __xpos __ypos _

      __width=300
      __height=400
      __orientation=vertical
    ;;

  esac

  case ${_o[anchor]:=1} in
    1   ) __anchor="north west" ;;
    2   ) __anchor="north" ;;
    3   ) __anchor="north east" ;;
    4   ) __anchor="west" ;;
    5   ) __anchor="center" ;;
    6   ) __anchor="east" ;;
    7   ) __anchor="south west" ;;
    8   ) __anchor="south" ;;
    9   ) __anchor="south east" ;;
    *   ) __anchor="north west" ;;
  esac

  ((${__height%px}<20)) && __height=20

  # overrides
  ((_o[height])) && __height=${_o[height]}
  ((_o[width]))  && __width=${_o[width]}
  ((_o[ypos]))   && __ypos=${_o[ypos]}
  ((_o[xpos]))   && __xpos=${_o[xpos]}


  [[ -n ${_o[xpos]:-} ]] && {
    if ((_o[xpos]<0)) || ((_o[xpos]==-0)); then
      __xpos=$((i3list[WAW]-((_o[xpos]*-1)+__width)))
    else
      __xpos=${_o[xpos]}
    fi
  }

  [[ ${_o[xoffset]} =~ ^[0-9-]+$ ]] && __xpos=$((__xpos+_o[xoffset]))
  [[ ${_o[yoffset]} =~ ^[0-9-]+$ ]] && __ypos=$((__ypos+_o[yoffset]))

  [[ ${__width} =~ [%]$ ]] || __width+=px
  __height+=px
}
