#!/usr/bin/env bash

printlist(){

  local crit="${1:-X}"
  local srch="${2:-X}"
  local toprint="${3:-all}"

  i3-msg -t get_tree | awk -f <(awklib) \
                           -F':' \
                           -v RS=',' \
                           -v crit="${crit}" \
                           -v srch="${srch}" \
                           -v toprint="${toprint}" 
}
