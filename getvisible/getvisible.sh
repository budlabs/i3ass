#!/usr/bin/env bash

__name="getvisible"
__version="0.004"
__author="budRich"
__contact='robstenklippa@gmail.com'
__created="2018-06-06"
__updated="2018-09-03"

main(){

  eval set -- "$(getopt --name "$__name" \
    --options vh::c:i: \
    --longoptions version,help::,class:,instance: \
    -- "$@"
  )"

  while true; do
    [[ $1 = -- ]] && option="$1" || {
      option="${1##--}" 
      option="${option##-}"   
    }

    case "$option" in

      i|c|instance|class )
        target=${option,,} target=${target:0:1} 
        arg="${2:-}"
        shift 2
      ;;

      v|version ) printinfo version  ; exit ;;
      h|help    ) printinfo "${2:-}" ; exit ;;
      -- ) shift ; break ;;
      *  ) break ;;

    esac
  done

  { [[ -z $target ]] || [[ -z $arg ]] ;} \
    && ERX "not valid $target $arg"

  found="$(i3viswiz "-${target}" | awk -v arg="$arg" '
    $NF~arg{print $2;exit}
  ')"

  [[ -z $found ]] \
    && ERX "$arg window not visible"

  echo "$found"
}

printinfo(){
about=\
'`getvisible` - Print the **con_id** of a visible window matching a criterion

SYNOPSIS
--------

`SCRIPTNAME` `-v`|`--version`   
`SCRIPTNAME` `-h`|`--help`   
`SCRIPTNAME` `-c`|`--class` CLASS   
`SCRIPTNAME` `-i`|`--instance` INSTANCE   

OPTIONS
-------

`-v`|`--version`  
Show version and exit.

`-h`|`--help`  
Show help and exit.

`-c`|`--class` CLASS  
Print the **con_id** of a  a visible window with a
matching CLASS.  

`-i`|`--instance` INSTANCE  
Print the **con_id** of a  a visible window with a
matching INSTANCE.  

DEPENDENCIES
------------

i3viswiz
'

bouthead="
${__name^^} 1 ${__created} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${__author} <${__contact}>
<https://budrich.github.io>

SEE ALSO
--------

i3viswiz(1), focusvisible
"


  case "$1" in
    # print version info to stdout
    version )
      printf '%s\n' \
        "$__name - version: $__version" \
        "updated: $__updated by $__author"
      exit
      ;;
    # print help in markdown format to stdout
    md ) printf '%s' "# ${about}" ;;

    # print help in markdown format to README.md
    mdg ) printf '%s' "# ${about}" > "${__dir}/README.md" ;;
    
    # print help in troff format to __dir/__name.1
    man ) 
      printf '%s' "${bouthead}" "${about}" "${boutfoot}" \
      | go-md2man > "${__dir}/${__name}.1"
    ;;

    # print help to stdout
    * ) 
      printf '%s' "${about}" | awk '
         BEGIN{ind=0}
         $0~/^```/{
           if(ind!="1"){ind="1"}
           else{ind="0"}
           print ""
         }
         $0!~/^```/{
           gsub("[`*]","",$0)
           if(ind=="1"){$0="   " $0}
           print $0
         }
       '
    ;;
  esac
}

ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

init(){
  __source="$(readlink -f "${BASH_SOURCE[0]}")"
  __dir="$(cd "$(dirname "${__source}")" && pwd)"
}

init
main "${@}"
