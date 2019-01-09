#!/usr/bin/env bash

main(){

  __dir="${1,,}"
  __dir=${__dir:0:1}

  # "$__dir not valid direction"
  [[ ! $__dir =~ u|r|l|d|n|p ]] \
    && ERX "$1 is not a valid direction"

  case "$__dir" in
    r|d ) __dir=n ;;
    l|u ) __dir=p ;;
  esac

  declare -A __acur

  eval "$(getcurrent)"
  
  __orgtrg="$(gettarget)"

  if ((${__o[move]:-0}!=1)); then
    [[ ! ${__acur[layout]:-} =~ tabbed|stacked ]] && {

      i3-msg -q focus parent
      eval "$(getcurrent)"

      [[ ! ${__acur[layout]:-} =~ tabbed|stacked ]] && {
        i3-msg -q "[con_id=$__orgtrg]" focus
        exit
      }

      __orgtrg="$(gettarget)"
    }
  fi

  if ((__acur[total]==1)); then
    ERX "only one window in container"
  elif ((${__o[move]:-1}!=1)); then
    movetarget
  else
    i3-msg -q "[con_id=$__orgtrg]" focus, focus child
  fi
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
