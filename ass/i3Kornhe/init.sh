#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3Kornhe - version: 0.026
updated: 2019-01-05 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3Kornhe - move and resize windows gracefully


SYNOPSIS
--------
i3Kornhe --help|-h
i3Kornhe --version|-v
i3Kornhe move [--speed|-p SPEED] [DIRECTION]
i3Kornhe size [--speed|-p SPEED] [DIRECTION]
i3Kornhe DIRECTION
i3Kornhe 1-9
i3Kornhe x

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v move  
Show version and exit.


--speed|-p DIRECTION  
Sets speed or distance in pixels to use when
moving and resizing the windows.
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "i3Kornhe" \
  --options "hv:p:" \
  --longoptions "help,version:,speed:," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]="${2:-}" ; shift ;;
    --speed      | -p ) __o[speed]="${2:-}" ; shift ;;
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

if [[ ${__o[help]:-} = 1 ]]; then
  ___printhelp
  exit
elif [[ ${__o[version]:-} = 1 ]]; then
  ___printversion
  exit
fi

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" \
  || true





