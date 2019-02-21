#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3var - version: 0.033
updated: 2019-02-19 by budRich
EOB
}



main(){

  local action trgnam trgval trgsts

  action="${1:-}"
  trgnam="${2:-}"
  trgval="${3:-}"
  
  trgsts="$(
    i3-msg -t get_marks | awk -v trg="$trgnam" -F',' '{
      gsub("[[]|\"|[]]","",$0)
      for(i=1;i<NF+1;i++){
        if($i~trg){print $i;exit}
      }
    }'
  )"

  if [[ $action = set ]]; then
    if [[ -n $trgval ]]; then
      if [[ -z $trgsts ]]; then
        i3gw "${trgnam}=${trgval}"
        i3-msg -q "[con_mark=${trgnam}]" move scratchpad
      elif [[ $trgval = X ]]; then
        i3-msg -q "[con_mark=${trgnam}]" kill
      else
        i3-msg -q "[con_mark=${trgnam}]", mark "${trgnam}=${trgval}"
      fi
    else
      i3-msg -q "[con_mark=${trgnam}]", mark "${trgnam}=X"
    fi
  elif [[ $action = get ]]; then
    trgsts="${trgsts#*=}"
    if [[ -z $trgsts ]] || [[ $trgsts = X ]]; then
      exit 1
    else
      echo "${trgsts}"
    fi
  else
    ___printhelp
  fi
}

___printhelp(){
  
cat << 'EOB' >&2
i3var - Set or get a i3 variable


SYNOPSIS
--------
i3var set VARNAME [VALUE]
i3var get VARNAME
i3var --help|-h
i3var --version|-v

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.
EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }
declare -A __o
eval set -- "$(getopt --name "i3var" \
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


main "${@:-}"


