#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3flip - version: 0.05
updated: 2019-02-19 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3flip - Tabswitching done right


SYNOPSIS
--------
i3flip DIRECTION
i3flip --move|-m DIRECTION
i3flip --help|-h
i3flip --version|-v

OPTIONS
-------

--move|-m DIRECTION  
Move the current tab instead of changing focus.

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
eval set -- "$(getopt --name "i3flip" \
  --options "m:hv" \
  --longoptions "move:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --move       | -m ) __o[move]="${2:-}" ; shift ;;
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





