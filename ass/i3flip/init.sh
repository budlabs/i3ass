#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3flip - version: 0.042
updated: 2019-01-05 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3flip - Tabswitching done right


SYNOPSIS
--------
i3flip --help|-h
i3flip --version|-v
i3flip --move|-m DIRECTION
i3flip DIRECTION

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.


--move|-m  
Move the current tab instead of changing focus.
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "i3flip" \
  --options "hvm" \
  --longoptions "help,version,move," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    --move       | -m ) __o[move]=1 ;; 
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





