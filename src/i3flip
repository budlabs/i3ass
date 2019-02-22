#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3flip - version: 0.052
updated: 2019-02-22 by budRich
EOB
}



main(){

  __dir="${1,,}"
  __dir=${__dir:0:1}

  # "$__dir not valid direction"
  [[ ! $__dir =~ u|r|l|d|n|p ]] \
    && ERX "$1 is not a valid direction"

  case "$__dir" in
    r|d ) __dir=n ;;
    l|u ) __dir=p ;;
  esac

  declare -A __acur

  eval "$(getcurrent)"
  
  __orgtrg="$(gettarget)"

  if ((${__o[move]:-0}!=1)); then
    [[ ! ${__acur[layout]:-} =~ tabbed|stacked ]] && {

      i3-msg -q focus parent
      eval "$(getcurrent)"

      [[ ! ${__acur[layout]:-} =~ tabbed|stacked ]] && {
        i3-msg -q "[con_id=$__orgtrg]" focus
        exit
      }

      __orgtrg="$(gettarget)"
    }
  fi

  if ((__acur[total]==1)); then
    ERX "only one window in container"
  elif ((${__o[move]:-0}==1)); then
    movetarget
  else
    i3-msg -q "[con_id=$__orgtrg]" focus, focus child
  fi
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

--move|-m  
Move the current tab instead of changing focus.

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

getcurrent(){
  i3-msg -t get_tree \
  | awk -v RS=',' -F':' -v crit='"focused"' -v srch="true" '
      BEGIN{fid="0";nid="0";nfo="0";nwi}

      $1~"{\"id\"" || $2~"\"id\"" {
        nwi=nwi+1;cid=$NF;aid[nwi]=cid}
      $1 ~ crit && $2 ~ srch  {fid=cid}
      $2 ~ crit && $3 ~ srch  {fid=cid}

      $1=="\"layout\"" {alo[cid]=$2}

      fid!="0" && $1=="\"focus\"" && $2~fid {focs=1}
      focs=="1" && $NF~"[]]$"{end=1}
      focs=="1" {gsub("[]]|[[]","",$NF);afo=$NF"|"afo;nfo++}
      end=="1" {
        j=nfo

        for (i=nwi;i>0;i--){
          if(fin==1){plo=alo[aid[i]];parid=aid[i];break}
          if(aid[i]==fid){n=j}
          if(afo ~ aid[i]){ord=aid[i]" "ord;--j}
          
          if(j==0){fin=1}
        }
        gsub("[\"]","",plo)

        print "__acur[position]=" n
        print "__acur[total]="    nfo
        print "__acur[layout]="   plo
        sub(/[[:space:]]*$/,"",ord)
        print "__acur[order]=\""  ord "\""
        print "__acur[parent]="   parid
        print "__acur[focused]="  fid

        exit
      } 
    '
}

gettarget(){
  local trg

  [[ $__dir = n ]] \
    && trg=$((__acur[position]==__acur[total]
              ? 1
              : __acur[position]+1
            )) \
    || trg=$((__acur[position]==1
              ? __acur[total]
              : __acur[position]-1
            ))

  aord=(${__acur[order]:-})
  echo "${aord[$((trg-1))]}"
}

movetarget(){
  # print id of window left of the one we want to move to.
  # if no warp is needed just print left|right
  local trg ldir curid trgid bdir

  [[ $__dir = n ]] \
    && trg=$((__acur[position]==__acur[total]
              ? 1
              : 0
            )) \
    || trg=$((__acur[position]==1
              ? __acur[total]
              : 0
            ))

  aord=(${__acur[order]:-})
  trgid="${aord[$((trg-1))]}"
  curid="${__acur[focused]}"

  if [[ ${__acur[layout]:-} =~ splith|stacked ]]; then
    # case "$__dir" in
    #   n) ldir=down ;;
    #   p) ldir=up   ;;
    # esac
    # bdir=up
    ERM "${__acur[layout]:-} moving with i3flip is currently only supported in tabbed or stacked containers"
    return 1
  else
    case "$__dir" in
      n) ldir=right ;;
      p) ldir=left   ;;
    esac
    bdir=left
  fi

  if ((trg==0)); then
    i3-msg -q "[con_id=$curid]" move "$ldir"
  else

    if ((trg==1)); then
      i3-msg -q "[con_id=$trgid]" mark fliptmp
      i3-msg -q "[con_id=$curid]" \
        move to mark fliptmp, \
        move "$bdir", \
        focus
      i3-msg -q "[con_id=$trgid]" unmark
    else
      i3-msg -q "[con_id=$trgid]" mark fliptmp
      i3-msg -q "[con_id=$curid]" move to mark fliptmp, focus
      i3-msg -q "[con_id=$trgid]" unmark
    fi
  fi
}
declare -A __o
eval set -- "$(getopt --name "i3flip" \
  --options "mhv" \
  --longoptions "move,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --move       | -m ) __o[move]=1 ;; 
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


