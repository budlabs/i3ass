#!/usr/bin/env bash

main(){

  local target type dir

  if [[ -n ${__o[title]:-} ]]; then
    type=title
    target="${__lastarg:-}"
  elif [[ -n ${__o[titleformat]:-} ]]; then
    type=titleformat
    target="${__lastarg:-}"
  elif [[ -n ${__o[instance]:-} ]]; then
    type=instance
    target="${__lastarg:-}"
  elif [[ -n ${__o[class]:-} ]]; then
    type=class
    target="${__lastarg:-}"
  elif [[ -n ${__o[winid]:-} ]]; then
    type=winid
    target="${__lastarg:-}"
  elif [[ -n ${__o[parent]:-} ]]; then
    type=parent
    target="${__lastarg:-}"
  else
    type="direction"
    target="${__lastarg:-}"
    target="${target,,}"
    target="${target:0:1}"

    [[ ! $target =~ l|r|u|d ]] && {
      ___printhelp
      exit
    }

  fi

  result="$(listvisible "$type" "${__o[gap]:=5}" "${target:-X}")"

  if ((${__o[focus]:-0}==1)); then
    [[ $result =~ ^[0-9]+$ ]] \
      && i3-msg -q "[con_id=$result]" focus \
      || exit 1
  elif [[ $type != direction ]]; then
    echo "$result"
  else
    eval "$(echo -e "$result" | head -1)"

    if [[ $trgcon = floating ]]; then

    case $target in
      l ) dir=left   ;;
      r ) dir=right  ;;
      u ) dir=left   ;;
      d ) dir=right  ;;
    esac

    i3-msg -q focus $dir

    else
      [[ -z $trgcon ]] && {
        eval "$(
          listvisible "$type" "$((__o[gap]+=75))" "${target:-X}" \
          | head -1
        )"
      }

      [[ -n $trgcon ]] \
        && i3-msg -q "[con_id=$trgcon]" focus
    fi
  fi
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
