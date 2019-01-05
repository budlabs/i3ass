#!/usr/bin/env bash

whosinstalled(){
  local longest_dep_name=0

  for d in "${@}"; do
    ((${#d}>longest_dep_name)) \
      && longest_dep_name=${#d}
  done

  header="$(printf '%-'${longest_dep_name:-15}'s | %s\n' \
        "script" "version")"
  echo "$header"
  echo "$header" | sed 's/./-/g'

  for d in "${@}"; do
    if [[ $(command -v "$d") ]]; then
      verre=$("$d" -v 2>&1 | awk '{print $NF;exit}')
      printf '%-'${longest_dep_name:-15}'s | %s\n' \
        "$d" "$verre"
    else
      printf '%-'${longest_dep_name:-15}'s version: %s\n' \
        "$d" "[NOT FOUND]"
    fi
  done
}
