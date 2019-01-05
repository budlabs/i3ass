#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main(){

  local tmark w

  IFS=$'\n\t'

  if [[ ${__o[help]:-} = 1 ]]; then
    ___printhelp
    exit
  elif [[ ${__o[version]:-} = 1 ]]; then
    ___printversion
    exit
  fi

  tmark="${1:-}"

  [[ -z $tmark ]] && {
    ___printhelp
    ERX "no name specified"
  }

  # w=$(i3-msg open | sed 's/[^0-9]//g')
  w="$(i3-msg open)"
  w="${w//[^0-9]/}"

  i3-msg -q "[con_id=$w]" floating disable, mark "$tmark"
  
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
