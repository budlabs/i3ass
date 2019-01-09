#!/usr/bin/env bash

main(){

  local action trgnam trgval trgsts

  action="${1:-}"
  trgnam="${2:-}"
  trgval="${3:-}"
  
  trgsts="$(
    i3-msg -t get_marks | awk -v trg="$trgnam" -F',' '{
      gsub("[[]|\"|[]]","",$0)
      for(i=1;i<NF+1;i++){
        if($i~trg){print $i;exit}
      }
    }'
  )"

  if [[ $action = set ]]; then
    if [[ -n $trgval ]]; then
      if [[ -z $trgsts ]]; then
        i3gw "${trgnam}=${trgval}"
        i3-msg -q "[con_mark=${trgnam}]" move scratchpad
      elif [[ $trgval = X ]]; then
        i3-msg -q "[con_mark=${trgnam}]" kill
      else
        i3-msg -q "[con_mark=${trgnam}]", mark "${trgnam}=${trgval}"
      fi
    else
      i3-msg -q "[con_mark=${trgnam}]", mark "${trgnam}=X"
    fi
  elif [[ $action = get ]]; then
    trgsts="${trgsts#*=}"
    if [[ -z $trgsts ]] || [[ $trgsts = X ]]; then
      exit 1
    else
      echo "${trgsts}"
    fi
  else
    ___printhelp
  fi
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
