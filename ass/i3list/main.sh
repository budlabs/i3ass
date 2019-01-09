#!/usr/bin/env bash

main(){

  local crit srch

  if [[ -z ${__o[*]:-} ]]; then
    crit=X srch=X
  elif [[ -n ${__o[instance]:-} ]]; then
    crit="instance" srch="${__o[instance]}"
  elif [[ -n ${__o[class]:-} ]]; then
    crit="class" srch="${__o[class]}"
  elif [[ -n ${__o[conid]:-} ]]; then
    crit="id" srch="${__o[conid]}"
  elif [[ -n ${__o[winid]:-} ]]; then
    crit="window" srch="${__o[winid]}"
  elif [[ -n ${__o[mark]:-} ]]; then
    crit="marks" srch="${__o[mark]}"
  elif [[ -n ${__o[title]:-} ]]; then
    crit="title" srch="${__o[title]}"
  else
    crit=X srch=X
  fi

  toprint="${1:-all}"
  printlist "$crit" "$srch" "$toprint"
  
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
