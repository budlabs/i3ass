#!/usr/bin/env bash

main(){
  local o result

  declare -A __crit

  for o in "${!__o[@]}"; do
    [[ $o =~ synk|active|print ]] && continue

    if [[ $o = conid ]]; then
      __crit[id]="${__o[$o]}"
    elif [[ $o = winid ]]; then
      __crit[window]="${__o[$o]}"
    elif [[ $o = mark ]]; then
      __crit[marks]="${__o[$o]}"
    elif [[ $o = titleformat ]]; then
      __crit[title_format]="${__o[$o]}"
    else
      __crit[$o]="${__o[$o]}"
    fi

  done

  ((${__o[active]:-0}==1)) && __crit[focused]="true"

  # if no search is given, search for active window
  ((${#__crit[@]}==0)) && __crit[focused]="true"

  result="$(getwindow)"

  ((${__o[synk]:-0}==1)) && {
    # timeout after 10 seconds
    for ((i=0;i<100;i++)); do 
      sleep 0.1
      result=$(getwindow)
      [ -n "$result" ] && break
    done
  }

  [ -n "$result" ] \
    && printf '%s\n' "${result}" \
    || ERX "no matching window."
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
