#!/bin/bash

next_vacant_workspace() {

  local ws_json ws_temp ws_free

  ws_json=$(i3-msg -t get_workspaces)

  while read -rs ; do
    if [[ $REPLY =~ \"num\":([0-9-]+) ]]; then
      ws_temp=${BASH_REMATCH[1]}
      ((ws_temp > ws_free)) && ws_free=$ws_temp
    fi
  done <<< "${ws_json//,/$'\n'}"

  echo "$((ws_free + 1))"
}
