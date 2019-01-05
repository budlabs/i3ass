#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3gw - version: 0.169
updated: 2019-01-05 by budRich
EOB
}



set -o errexit
set -o pipefail
set -o nounset

main(){

  local tmark w

  IFS=$'\n\t'

  if [[ ${__o[help]:-} = 1 ]]; then
    ___printhelp
    exit
  elif [[ ${__o[version]:-} = 1 ]]; then
    ___printversion
    exit
  fi

  tmark="${1:-}"

  [[ -z $tmark ]] && {
    ___printhelp
    ERX "no name specified"
  }

  # w=$(i3-msg open | sed 's/[^0-9]//g')
  w="$(i3-msg open)"
  w="${w//[^0-9]/}"

  i3-msg -q "[con_id=$w]" floating disable, mark "$tmark"
  
}

___printhelp(){
  
cat << 'EOB' >&2
i3gw - a ghost window wrapper for i3wm


SYNOPSIS
--------
i3gw --help|-h
i3gw --version|-v
i3gw MARK

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v MARK  
Show version and exit.
EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }
declare -A __o
eval set -- "$(getopt --name "i3gw" \
  --options "hv:" \
  --longoptions "help,version:," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]="${2:-}" ; shift ;;
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


main "${@:-}"


