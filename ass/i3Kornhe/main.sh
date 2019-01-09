#!/usr/bin/env bash

main(){
  # globals for absolute positioning
  __border_top=25 __border_bot=5
  __border_left=5 __border_right=5

  __mode="${1:0:1}"
  __mode="${__mode,,}"

  [[ $__mode = x ]] && exit_mode

  declare -A i3list
  eval "$(i3list)"

  [[ $__mode =~ ^[1-9]$ ]] && ((i3list[AWF]==1)) \
    && move_absolute

  __speed="${__o[speed]:=10} px or ${__o[speed]} ppt"

  __dir=${__lastarg,,}
  __dir=${__dir:0:1}

  if [[ $__mode =~ s|m ]] && ((i3list[AWF]==1)); then
    # new mode, clear old
    i3var set sizemode
    curmo=""
    i3var get sizetits || current_tf
  elif [[ $__mode = m ]] && ((i3list[AWF]!=1)) && ((i3list[WSA]==i3list[WSF])); then 
    # if window is tiled and workspace is i3fyra
    i3fyra -m "$__dir"
    exit
  else
    curmo="$(i3var get sizemode)"
  fi

  case "$__dir" in

    l  ) 
      __varmode="topleft"
      tilesize="shrink width"
    ;;

    r ) 
      __varmode="bottomright"
      tilesize="grow width"
    ;;

    u    ) 
      __varmode="topright"
      tilesize="grow height" 
    ;;

    d  ) 
      __varmode="bottomleft"
      tilesize="shrink height" 
    ;;

  esac

  if ((i3list[AWF]!=1)); then
    # resize tiled
    i3-msg -q resize "$tilesize" "${__speed}"
  else

    if [[ $__mode = m ]]; then
      __varmode=move
      __title="MOVE"
    else
      __title="SIZE:${curmo:-$__varmode}"
    fi

    if [[ -z $curmo ]]; then 
      enter_mode
    else
      apply_action "$curmo"
    fi
  fi
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
