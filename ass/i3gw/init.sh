#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3gw - version: 0.174
updated: 2019-02-19 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3gw - a ghost window wrapper for i3wm


SYNOPSIS
--------
i3gw MARK
i3gw --help|-h
i3gw --version|-v

OPTIONS
-------

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
eval set -- "$(getopt --name "i3gw" \
  --options "hv" \
  --longoptions "help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
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





