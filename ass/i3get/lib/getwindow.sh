#!/usr/bin/env bash

getwindow(){
  {
    for c in "${!__crit[@]}"; do
      echo -n "$c:${__crit[$c]},"
    done

    echo -n "__START__,"

    i3-msg -t get_tree
  } | awk -v RS=',' -F':' -v sret="${__o[print]:-n}" -f <(awklib)
    
}
