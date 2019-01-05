#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3list - version: 0.025
updated: 2019-01-05 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3list - list information about the current i3 session.


SYNOPSIS
--------
i3list --help|-h
i3list --version|-v
i3list --instance|-i TARGET
i3list --class|-c    TARGET
i3list --conid|-n    TARGET
i3list --winid|-d    TARGET
i3list --mark|-m     TARGET
i3list --title|-t    TARGET

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.


--instance|-i TARGET  
Search for windows with a instance matching
TARGET


--class|-c TARGET  
Search for windows with a class matching TARGET


--conid|-n TARGET  
Search for windows with a CON_ID matching TARGET


--winid|-d TARGET  
Search for windows with a WINDOW_ID matching
TARGET


--mark|-m TARGET  
Search for windows with a mark matching TARGET


--title|-t TARGET  
Search for windows with a title matching TARGET 
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "i3list" \
  --options "hvi:c:n:d:m:t:" \
  --longoptions "help,version,instance:,class:,conid:,winid:,mark:,title:," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --conid      | -n ) __o[conid]="${2:-}" ; shift ;;
    --winid      | -d ) __o[winid]="${2:-}" ; shift ;;
    --mark       | -m ) __o[mark]="${2:-}" ; shift ;;
    --title      | -t ) __o[title]="${2:-}" ; shift ;;
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





