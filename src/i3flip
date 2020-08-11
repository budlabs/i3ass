#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3flip - version: 0.099
updated: 2020-08-09 by budRich
EOB
}



main(){

  declare -g _msgstring
  declare -i next prev

  _dir=$1
  ((__o[verbose])) && ERM "target direction: $_dir"
  _dir=${_dir,,}

  eval "$(i3viswiz -p ${__o[json]:+--json "${__o[json]}"} | head -1)"
  # unset unneeded variabels from viswiz
  unset trgcon trgx trgy wall trgpar sx sy sw sh groupid

  # by creating the wiz string, shellcheck will
  # not complain about un-assigned variables 
  wiz+="layout:${grouplayout:=} last:${lastingroup:=} "
  wiz+="first:${firstingroup:=} "
  wiz+="pos:${grouppos:=} size:${groupsize:=0} "

  ((__o[verbose])) && ERM "w $wiz"

  ((groupsize < 2)) && ERX only container in group

  case "${_dir:0:1}" in

    r|d|n ) 
      next=1 prev=0
      [[ "$grouplayout" =~ tabbed|splith ]] \
        && ldir=right || ldir=down
    ;;

    l|u|p )
      prev=1 next=0
      [[ "$grouplayout" =~ tabbed|splith ]] \
        && ldir=left || ldir=up
    ;;

    *     ) ERX "$1 is not a valid direction" ;;
  esac

  # focus/move normally
  if (( (grouppos  > 1 && grouppos < groupsize)       
   || ( (grouppos == 1 && next)
   ||   (grouppos == groupsize && prev) ) )); then
   
   ((__o[move])) && cmd=move || cmd=focus
   messy "$cmd  $ldir"
  
  # warp focus/move to end of group
  elif ((grouppos == 1)); then
    if ((__o[move])); then
      messy "[con_id=$lastingroup] mark --add --toggle fliptmp"
      messy "move to mark fliptmp"
      messy "[con_id=$lastingroup] mark --add --toggle fliptmp"
    else
      messy "[con_id=$lastingroup] focus"
    fi

  # warp focus/move to start of group, (move+swap)
  else
    if ((__o[move])); then
      messy "[con_id=$firstingroup] mark --add --toggle fliptmp"
      messy "move to mark fliptmp, swap container with mark fliptmp"
      messy "[con_id=$firstingroup] mark --add --toggle fliptmp"
    else
      messy "[con_id=$firstingroup] focus"
    fi
  fi

  ((__o[verbose])) || qflag='-q'
  [[ -n $_msgstring ]] && i3-msg "${qflag:-}" "$_msgstring"
}

___printhelp(){
  
cat << 'EOB' >&2
i3flip - Tabswitching done right


SYNOPSIS
--------
i3flip [--move|-m] [--json JSON] [--verbose] [--dryrun] DIRECTION
i3flip --help|-h
i3flip --version|-v

OPTIONS
-------

--move|-m  
Move the current container instead of changing
focus.


--json JSON  
use JSON instead of output from  i3-msg -t
get_tree


--verbose  
Print more information to stderr.


--dryrun  
Don't execute any i3 commands.

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


set -E
trap '[ "$?" -ne 98 ] || exit 98' ERR

ERX() { >&2 echo  "[ERROR] $*" ; exit 98 ;}
ERR() { >&2 echo  "[WARNING] $*"  ;}
ERM() { >&2 echo  "$*"  ;}
ERH(){
  ___printhelp >&2
  [[ -n "$*" ]] && printf '\n%s\n' "$*" >&2
  exit 98
}

messy() {
  # arguments are valid i3-msg arguments
  (( __o[verbose] )) && ERM "m $*"
  (( __o[dryrun]  )) || _msgstring+="$*;"
}


declare -A __o
options="$(
  getopt --name "[ERROR]:i3flip" \
    --options "mhv" \
    --longoptions "move,json:,verbose,dryrun,help,version," \
    -- "$@" || exit 98
)"

eval set -- "$options"
unset options

while true; do
  case "$1" in
    --move       | -m ) __o[move]=1 ;; 
    --json       ) __o[json]="${2:-}" ; shift ;;
    --verbose    ) __o[verbose]=1 ;; 
    --dryrun     ) __o[dryrun]=1 ;; 
    --help       | -h ) ___printhelp && exit ;;
    --version    | -v ) ___printversion && exit ;;
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" 


main "${@}"


