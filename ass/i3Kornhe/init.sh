#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3Kornhe - version: 0.033
updated: 2019-02-19 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3Kornhe - move and resize windows gracefully


SYNOPSIS
--------
i3Kornhe DIRECTION
i3Kornhe move [--speed|-p SPEED] [DIRECTION]
i3Kornhe size [--speed|-p SPEED] [DIRECTION]
i3Kornhe 1-9
i3Kornhe x
i3Kornhe --help|-h
i3Kornhe --version|-v

OPTIONS
-------

--speed|-p SPEED  
Sets speed or distance in pixels to use when
moving and resizing the windows.

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "i3Kornhe" \
  --options "p:hv" \
  --longoptions "speed:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --speed      | -p ) __o[speed]="${2:-}" ; shift ;;
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
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





