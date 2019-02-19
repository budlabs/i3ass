#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3Kornhe - version: 0.033
updated: 2019-02-19 by budRich
EOB
}



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

___printhelp(){
  
cat << 'EOB' >&2
i3Kornhe - move and resize windows gracefully


SYNOPSIS
--------
i3Kornhe DIRECTION
i3Kornhe move [--speed|-p SPEED] [DIRECTION]
i3Kornhe size [--speed|-p SPEED] [DIRECTION]
i3Kornhe 1-9
i3Kornhe x
i3Kornhe --help|-h
i3Kornhe --version|-v

OPTIONS
-------

--speed|-p SPEED  
Sets speed or distance in pixels to use when
moving and resizing the windows.

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


apply_action(){
  local curmo action floatsize

  curmo="$1"
  action=resize

  case "$curmo" in
    topleft )
      case "$__dir" in
        u ) floatsize="grow up"      ;;
        d ) floatsize="shrink up"    ;;
        l ) floatsize="grow left"    ;;
        r ) floatsize="shrink left"  ;;
      esac
    ;;

    topright )
      case "$__dir" in
        u ) floatsize="grow up"      ;;
        d ) floatsize="shrink up"    ;;
        l ) floatsize="shrink right" ;;
        r ) floatsize="grow right"   ;;
      esac
    ;;

    bottomleft )
      case "$__dir" in
        u ) floatsize="shrink down"   ;;
        d ) floatsize="grow down"     ;;
        l ) floatsize="grow left"     ;;
        r ) floatsize="shrink left"   ;;
      esac
    ;;

    bottomright )
      case "$__dir" in
        u ) floatsize="shrink down"   ;;
        d ) floatsize="grow down"     ;;
        l ) floatsize="shrink right"  ;;
        r ) floatsize="grow right"    ;;
      esac
    ;;

    move )

      case "$__dir" in
        u ) floatsize="up"       ;;
        d ) floatsize="down"     ;;
        l ) floatsize="left"     ;;
        r ) floatsize="right"    ;;
      esac

      action=move
      __title=MOVE
    ;;

  esac

  i3-msg -q $action ${floatsize} "${__speed}"
  set_tf
}

enter_mode(){ 

  i3var set sizemode $__varmode
  i3var get sizetits || current_tf

  i3var set sizecon "${i3list[AWC]}"

  set_tf
  i3-msg -q mode sizemode

  exit
}

ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

exit_mode(){
  local tits

  i3var set sizemode
  i3-msg -q mode "default"
  tits="$(i3var get sizetits)"



  [[ -n ${tits:-} ]] \
    && tits="${tits//\\}" \
    || tits='%title'

  sizecon="$(i3var get sizecon)"

  i3var set sizetits
  i3var set sizecon

  i3-msg -q "[con_id=$sizecon]" title_format "${tits}"
  exit
}

move_absolute(){
  local dir xpos ypos
  dir=$__lastarg

  ypos=$((
    dir<4 ? i3list[WAY]+__border_top :
    dir<7 ? i3list[WAY]+(i3list[WAH]/2)-(i3list[AWH]/2) 
          : i3list[WAY]+(i3list[WAH]-(i3list[AWH]+__border_bot))
  ))
  
  xpos=$((
    (dir==1||dir==4||dir==7) ? i3list[WAX]+__border_left :         
    (dir==2||dir==5||dir==8) ? i3list[WAX]+(i3list[WAW]/2-(i3list[AWW]/2))
    : i3list[WAX]+(i3list[WAW]-(i3list[AWW]+__border_right))         
  ))

  i3-msg -q "[con_id=${i3list[AWC]}]" move absolute position $xpos $ypos
  __title="MOVE"
  set_tf
  exit
}

set_tf(){
  local tf

  eval "$(i3list)"

  tf="$(
    printf '%s w:%s h:%s x:%s y:%s' \
      "$__title" "${i3list[AWW]}" "${i3list[AWH]}" \
      "${i3list[AWX]}" "${i3list[AWY]}"
  )"

  i3-msg -q "[con_id=${i3list[AWC]}]" title_format "${tf}"
}

current_tf(){
  local curtf

  curtf="$(i3get -r o)"
  [[ ! ${curtf:-} =~ ^\"*(MOVE|SIZE) ]] && {
    i3var set sizetits "$curtf"
  }
}
declare -A __o
eval set -- "$(getopt --name "i3Kornhe" \
  --options "p:hv" \
  --longoptions "speed:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --speed      | -p ) __o[speed]="${2:-}" ; shift ;;
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

if [[ ${__o[help]:-} = 1 ]]; then
  ___printhelp
  exit
elif [[ ${__o[version]:-} = 1 ]]; then
  ___printversion
  exit
fi

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" \
  || true


main "${@:-}"


