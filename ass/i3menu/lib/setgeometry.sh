#!/usr/bin/env bash

defaultoffset(){
  __xpos=0
  __ypos=0
  __o[xoffset]=0
  __o[yoffset]=0
  __o[width]="100%"
  __height=20
  __o[layout]=default
  __orientation=horizontal
  __anchor=1
}

setfallback(){

 __o[fallback]=""

 eval set -- "$(getopt --name "i3menu" \
   --options "a:i:t:x:y:w:o:p:f:" \
   --longoptions "theme:,layout:,include:,top:,xpos:,xoffset:,ypos:,yoffset:,width:,options:,prompt:,filter:,show:,modi:,target:,orientation:,anchor:,height:,fallback:" \
   -- "$@"
 )"

 while true; do
   case "$1" in
     --theme      ) __o[theme]="${2:-}" ; shift ;;
     --layout     | -a ) __o[layout]="${2:-}" ; shift ;;
     --include    | -i ) __o[include]="${2:-}" ; shift ;;
     --top        | -t ) __o[top]="${2:-}" ; shift ;;
     --xpos       | -x ) __o[xpos]="${2:-}" ; shift ;;
     --xoffset    ) __o[xoffset]="${2:-}" ; shift ;;
     --ypos       | -y ) __o[ypos]="${2:-}" ; shift ;;
     --yoffset    ) __o[yoffset]="${2:-}" ; shift ;;
     --width      | -w ) __o[width]="${2:-}" ; shift ;;
     --options    | -o ) __o[options]="${2:-}" ; shift ;;
     --prompt     | -p ) __o[prompt]="${2:-}" ; shift ;;
     --filter     | -f ) __o[filter]="${2:-}" ; shift ;;
     --show       ) __o[show]="${2:-}" ; shift ;;
     --modi       ) __o[modi]="${2:-}" ; shift ;;
     --target     ) __o[target]="${2:-}" ; shift ;;
     --orientation ) __o[orientation]="${2:-}" ; shift ;;
     --anchor     ) __o[anchor]="${2:-}" ; shift ;;
     --height     | -h ) __o[height]="${2:-}" ; shift ;;
     --fallback   ) __o[fallback]="${2:-}" ; shift ;;
     -- ) shift ; break ;;
     *  ) break ;;
   esac
   shift
 done 
}

setgeometry(){

  __layout="$1"

  # i3list[TWB]=20               # Target Window titlebar height
  # i3list[TWC]=94179890124352   # Target Window con_id
  # i3list[TTW]=257              # Target Window tab width
  # i3list[TTX]=0                # Target Window tab x postion
  # i3list[TWH]=220              # Target Window height
  # i3list[TWW]=514              # Target Window width
  # i3list[TWX]=0                # Target Window x position
  # i3list[TWY]=0                # Target Window y position
  # i3list[CAL]=tabbed           # Container A Layout
  # i3list[CBL]=tabbed           # Container B Layout
  # i3list[SAB]=514              # Current split: AB
  # i3list[SAC]=220              # Current split: AC
  # i3list[SBD]=220              # Current split: BD
  # i3list[SCD]=1080             # Current split: CD
  # i3list[LVI]=CBA              # Visible i3fyra containers
  # i3list[WAH]=1920             # Active Workspace height
  # i3list[WAW]=1080             # Active Workspace width
  # i3list[WAX]=0                # Active Workspace x position
  # i3list[WAY]=0                # Active Workspace y position

  # default geometry
  : "${__xpos:=${__o[xpos]:-0}}"
  : "${__ypos:=${__o[ypos]:-0}}"
  : "${__o[xoffset]:=0}"
  : "${__o[yoffset]:=0}"
  : "${__o[width]:="100%"}"
  : "${__height:=${__o[height]:-20}}"
  : "${__o[anchor]:=1}"
  : "${__orientation:=horizontal}"

  # if layout is window or container, but no list titlebar
  [[ $__layout =~ A|B|C|D|window ]] && [[ -z ${__list:-} ]] && {
    defaultoffset
    if [[ -n ${__o[fallback]:-} ]]; then
      __layout=fallback
      eval setfallback ${__o[fallback]}
      setgeometry "${__o[layout]:-default}"
      return
    else
      __layout=titlebar
    fi
  }

  # if layout is container but container is not visible
  [[ $__layout =~ A|B|C|D ]] && [[ ! ${i3list[LVI]} =~ [${__o[layout]}] ]] && {
    defaultoffset
    if [[ -n ${__o[fallback]:-} ]]; then
      __layout=fallback
      eval setfallback ${__o[fallback]}
      setgeometry "${__o[layout]:-default}"
      return
    else
      __layout=default
    fi
  }

  # if layout is window, tab or titlebar but no target window, default
  [[ $__layout =~ window|tab|titlebar ]] && [[ -z ${i3list[TWC]} ]] && {
    defaultoffset
    if [[ -n ${__o[fallback]:-} ]]; then
      __layout=fallback
      eval setfallback ${__o[fallback]}
      setgeometry "${__o[layout]:-default}"
      return
    else
      __layout=default
    fi
  }

  case "$__layout" in

    titlebar  ) 
      __ypos=$((i3list[TWY]+i3list[WAY]))
      __xpos=$((i3list[TWX]+i3list[WAX]))
      __o[width]=${i3list[TWW]}
      __height=${i3list[TWB]}
      __orientation=horizontal
    ;;

    window    )
        __xpos=$((i3list[TWX]+i3list[WAX]))
        __ypos=$((i3list[TWY]+i3list[WAY]))
        __o[width]=${i3list[TWW]}
        __height=${i3list[TWH]}
        __orientation=vertical
        __o[orientation]=""
    ;;

    bottom )
      __ypos=$((i3list[WAH]-i3list[AWB]))
    ;;

    tab       ) 
      if ((i3list[TTW]==i3list[TWW])); then
        __xpos=$((i3list[TWX]+i3list[WAX]))
        __o[width]=${i3list[TWW]}
      else
        __xpos=$((i3list[TTX]+i3list[TWX]))
        __o[width]=${i3list[TTW]}
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
          __o[width]=${i3list[SAB]:-${i3list[WAW]}}
          __height=${i3list[SAC]:-${i3list[WAH]}}
        ;;

        B) 
          __xpos=${i3list[SAB]:-0}
          __ypos=0
          __o[width]=$((i3list[WAW]-__xpos))
          __height=${i3list[SBD]:-${i3list[SAC]:-${i3list[WAH]}}}
        ;;

        C) 
          __xpos=0
          __ypos=${i3list[SAC]:-0}
          __o[width]=${i3list[SCD]:-${i3list[SAB]:-${i3list[WAW]}}}
          __height=$((i3list[WAH]-__ypos))
          echo $__ypos
        ;;

        D) 
          __xpos=${i3list[SCD]:-${i3list[SAB]:-0}}
          __ypos=${i3list[SBD]:-0}
          __o[width]=$((i3list[WAW]-__xpos))
          __height=$((i3list[WAH]-__ypos))
        ;;
      esac
      __orientation=vertical
      __o[orientation]=""
    ;;

    mouse )
      declare -A __mouse

      eval "$(xdotool getmouselocation --shell | \
        awk -v FS='=' '{
          printf("__mouse[%s]=%s\n",$1,$2)
        }'
      )"

      __xpos="$((__mouse[X]))"
      __ypos="$((__mouse[Y]))"
    ;;

  esac

  case ${__o[anchor]:-1} in
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

  [[ -n ${__o[xpos]:-} ]] && __xpos=${__o[xpos]}
  [[ -n ${__o[ypos]:-} ]] && __ypos=${__o[ypos]}
  ((__o[xoffset]>0)) && __xpos=$((__xpos+__o[xoffset]))
  ((__o[yoffset]>0)) && __ypos=$((__ypos+__o[yoffset]))

  [[ ${__o[width]} =~ [%]$ ]] || __o[width]=${__o[width]}px
  ((__height<20)) && __height=20
  [[ -n ${__o[height]} ]] && __height="${__o[height]}"
  __height+="px"
}
