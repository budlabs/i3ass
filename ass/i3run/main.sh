#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main(){

  if [[ -n ${__o[instance]} ]]; then
    acri=("-i" "${__o[instance]}")
  elif [[ -n ${__o[class]} ]]; then
    acri=("-c" "${__o[class]}")
  elif [[ -n ${__o[title]} ]]; then
    acri=("-t" "${__o[title]}")
  elif [[ -n ${__o[conid]} ]]; then
    acri=("-n" "${__o[conid]}")
  else
    ___printhelp
    ERX "please specify a criteria"
  fi

  declare -A i3list # globals array
  eval "$(i3list "${acri[@]}")"

  # if window doesn't exist, launch the command.
  [[ -z ${i3list[TWC]} ]] \
    && launchcommand \
    || focuswindow
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
