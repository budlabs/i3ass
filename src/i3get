#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3get - version: 0.331
updated: 2019-01-08 by budRich
EOB
}



main(){
  local o result

  declare -A __crit

  for o in "${!__o[@]}"; do
    [[ $o =~ synk|active|print ]] && continue

    if [[ $o = conid ]]; then
      __crit[id]="${__o[$o]}"
    elif [[ $o = winid ]]; then
      __crit[window]="${__o[$o]}"
    elif [[ $o = mark ]]; then
      __crit[marks]="${__o[$o]}"
    elif [[ $o = titleformat ]]; then
      __crit[title_format]="${__o[$o]}"
    else
      __crit[$o]="${__o[$o]}"
    fi

  done

  ((${__o[active]:-0}==1)) && __crit[focused]="true"

  # if no search is given, search for active window
  ((${#__crit[@]}==0)) && __crit[focused]="true"

  result="$(getwindow)"

  ((${__o[synk]:-0}==1)) && {
    # timeout after 10 seconds
    for ((i=0;i<100;i++)); do 
      sleep 0.1
      result=$(getwindow)
      [ -n "$result" ] && break
    done
  }

  [ -n "$result" ] \
    && printf '%s\n' "${result}" \
    || ERX "no matching window."
}

___printhelp(){
  
cat << 'EOB' >&2
i3get - Boilerplate and template maker for bash scripts


SYNOPSIS
--------
i3get [--class|-c CLASS] [--instance|-i INSTANCE] [--title|-t TITLE] [--conid|-n CON_ID] [--winid|-d WIN_ID] [--mark|-m MARK] [--titleformat|-o TITLE_FORMAT] [--active|-a] [--synk|-y] [--print|-r OUTPUT]      
i3get --help|-h
i3get --version|-v

OPTIONS
-------

--class|-c CLASS  
Search for windows with the given class


--instance|-i INSTANCE  
Search for windows with the given instance


--title|-t TITLE  
Search for windows with title.


--conid|-n CON_ID  
Search for windows with the given con_id


--winid|-d WIN_ID  
Search for windows with the given window id


--mark|-m MARK  
Search for windows with the given mark


--titleformat|-o TITLE_FORMAT  
Search for windows with the given titleformat


--active|-a  
Currently active window (default)


--synk|-y  
Synch on. If this option is included,  
script will wait till target window exist.


--print|-r OUTPUT  
OUTPUT can be one or more of the following 
characters:  

|character | print
|:---------|:-----
|t       | title  
|c       | class  
|i       | instance  
|d       | Window ID  
|n       | Con_Id (default)  
|m       | mark  
|w       | workspace  
|a       | is active  
|f       | floating state  
|o       | title format  
|v       | visible state  


--help|-h  
Show help and exit.


--version|-v  
Show version and exit

EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

getwindow(){
  {
    for c in "${!__crit[@]}"; do
      echo -n "$c:${__crit[$c]},"
    done

    echo -n "__START__,"

    i3-msg -t get_tree
  } | awk -v RS=',' -F':' -v sret="${__o[print]:-n}" '
    BEGIN {hit=0;start=0;trg=0}

      # set crit array
      start==0 && $0 !~ "__START__" && /./ {
        crit[$1]=$2
        trg++
      }

      # reset return array
      $(NF-1) ~ /"id"$/ {
        if (hit == trg) exit
        cid=$NF
        hit=0
        for(k in r){if(k!="w"){r[k]=""}}
        if(sret ~ n)
          r["n"]=cid
        
      }

      start==1 && hit!=trg {
        for (c in crit) {
          if ($(NF-1) ~ "\"" c "\"" && $NF ~ crit[c]) {
            if (fid==cid) {hit++}
            else {hit=1;fid=cid}
          }
        }
      }


      sret ~ "t" && $1=="\"title\"" {sub($1":","");r["t"]=$0}
      sret ~ "c" && $(NF-1) ~ "\"class\"" {r["c"]=$NF}
      sret ~ "i" && $1=="\"instance\"" {r["i"]=$2}
      sret ~ "d" && $1=="\"window\"" {r["d"]=$2}
      sret ~ "m" && $1=="\"marks\"" {r["m"]=$2}
      sret ~ "a" && $1=="\"focused\"" {r["a"]=$2}
      sret ~ "o" && $1=="\"title_format\"" {r["o"]=$2}
      sret ~ "w" && $1=="\"num\"" {r["w"]=$2}
      sret ~ "f" && $1=="\"floating\"" {r["f"]=$2}
      
      /__START__/ {start=1}

    END{
      if (hit==0) exit
      split(sret, aret, "")
      for (i=1; i <= length(sret); i++) {
        op=r[aret[i]]
        gsub(/^["]|["]$/,"",op)
        if(op!="")
          printf("%s\n", op)
      }
    }
    '
}
declare -A __o
eval set -- "$(getopt --name "i3get" \
  --options "c:i:t:n:d:m:o:ayr:hv" \
  --longoptions "class:,instance:,title:,conid:,winid:,mark:,titleformat:,active,synk,print:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --title      | -t ) __o[title]="${2:-}" ; shift ;;
    --conid      | -n ) __o[conid]="${2:-}" ; shift ;;
    --winid      | -d ) __o[winid]="${2:-}" ; shift ;;
    --mark       | -m ) __o[mark]="${2:-}" ; shift ;;
    --titleformat | -o ) __o[titleformat]="${2:-}" ; shift ;;
    --active     | -a ) __o[active]=1 ;; 
    --synk       | -y ) __o[synk]=1 ;; 
    --print      | -r ) __o[print]="${2:-}" ; shift ;;
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


