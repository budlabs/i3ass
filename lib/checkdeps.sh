#!/usr/bin/env bash

checkdeps(){
  local status
  local longest_dep_name=0

  for d in "${@}"; do
    ((${#d}>longest_dep_name)) \
      && longest_dep_name=${#d}
  done

  : $((longest_dep_name+=1))

  for d in "${@}"; do
    command -v "$d" > /dev/null 2>&1 \
      && status="[INSTALLED]" \
      || status="[NOT FOUND]"

    printf '%-'${longest_dep_name:-15}'s %s\n' \
      "$d" "$status"
  done
}
