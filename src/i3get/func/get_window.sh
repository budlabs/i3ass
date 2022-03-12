#!/bin/bash

get_window() {

  local json
  json=${_o[json]:-$(i3-msg -t get_tree)}

  for o in instance class conid winid mark title titleformat type role parent; do

    [[ ${_o[$o]} ]] || continue

    case "$o" in
      role        ) json_key=window_role     ;;
      type        ) json_key=window_type     ;;
      titleformat ) json_key=title_format    ;;
      parent      ) json_key=i3fyracontainer ;;
      title       ) json_key=name            ;;
      winid       ) json_key=window          ;;
      conid       ) json_key=id              ;;
      mark        ) json_key=marks           ;;
      *           ) json_key=$o              ;;
    esac

    begin_block+="arg_search[\"$json_key\"]=\"${_o[$o]}\";"

  done

  <<< "$json" gawk -f <(
    echo "BEGIN { $begin_block }"
    _awklib
  ) FS=: RS=, \
    arg_print="${_o[print]:-n}" \
    arg_print_format="${_o[print-format]:-%v\n}"
}
