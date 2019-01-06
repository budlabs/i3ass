#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3get - version: 0.328
updated: 2019-01-06 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3get - Boilerplate and template maker for bash scripts


SYNOPSIS
--------
i3get --help|-h
i3get --version|-v
i3get [--class|-c CLASS] [--instance|-i INSTANCE] [--title|-t TITLE] [--conid|-n CON_ID] [--winid|-d WIN_ID] [--mark|-m MARK] [--titleformat|-o TITLE_FORMAT] [--active|-a] [--synk|-y] [--print|-r OUTPUT]      

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v  
Show version and exit


--class|-c CLASS  
Search for windows with the given class


--instance|-i INSTANCE  
Search for windows with the given instance


--title|-t TITLE  
Search for windows with title.


--conid|-n  
Search for windows with the given con_id


--winid|-d  
Search for windows with the given window id


--mark|-m MARK  
Search for windows with the given mark


--titleformat|-o  
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

EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "i3get" \
  --options "hvc:i:t:ndm:oayr:" \
  --longoptions "help,version,class:,instance:,title:,conid,winid,mark:,titleformat,active,synk,print:," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --title      | -t ) __o[title]="${2:-}" ; shift ;;
    --conid      | -n ) __o[conid]=1 ;; 
    --winid      | -d ) __o[winid]=1 ;; 
    --mark       | -m ) __o[mark]="${2:-}" ; shift ;;
    --titleformat | -o ) __o[titleformat]=1 ;; 
    --active     | -a ) __o[active]=1 ;; 
    --synk       | -y ) __o[synk]=1 ;; 
    --print      | -r ) __o[print]="${2:-}" ; shift ;;
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




