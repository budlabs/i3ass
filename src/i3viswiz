#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3viswiz - version: 0.044
updated: 2019-02-19 by budRich
EOB
}



main(){

  local target type dir

  if [[ -n ${__o[title]:-} ]]; then
    type=title
    target="${__lastarg:-}"
  elif [[ -n ${__o[titleformat]:-} ]]; then
    type=titleformat
    target="${__lastarg:-}"
  elif [[ -n ${__o[instance]:-} ]]; then
    type=instance
    target="${__lastarg:-}"
  elif [[ -n ${__o[class]:-} ]]; then
    type=class
    target="${__lastarg:-}"
  elif [[ -n ${__o[winid]:-} ]]; then
    type=winid
    target="${__lastarg:-}"
  elif [[ -n ${__o[parent]:-} ]]; then
    type=parent
    target="${__lastarg:-}"
  else
    type="direction"
    target="${__lastarg:-}"
    target="${target,,}"
    target="${target:0:1}"

    [[ ! $target =~ l|r|u|d ]] && {
      ___printhelp
      exit
    }

  fi

  result="$(listvisible "$type" "${__o[gap]:=5}" "${target:-X}")"

  if ((${__o[focus]:-0}==1)); then
    [[ $result =~ ^[0-9]+$ ]] \
      && i3-msg -q "[con_id=$result]" focus \
      || exit 1
  elif [[ $type != direction ]]; then
    echo "$result"
  else
    eval "$(echo -e "$result" | head -1)"

    if [[ $trgcon = floating ]]; then

    case $target in
      l ) dir=left   ;;
      r ) dir=right  ;;
      u ) dir=left   ;;
      d ) dir=right  ;;
    esac

    i3-msg -q focus $dir

    else
      [[ -z $trgcon ]] && {
        eval "$(
          listvisible "$type" "$((__o[gap]+=75))" "${target:-X}" \
          | head -1
        )"
      }

      [[ -n $trgcon ]] \
        && i3-msg -q "[con_id=$trgcon]" focus
    fi
  fi
}

___printhelp(){
  
cat << 'EOB' >&2
i3viswiz - Professional window focus for i3wm


SYNOPSIS
--------
i3viswiz [--gap|-g GAPSIZE] DIRECTION
i3viswiz [--focus|-f] --title|-t       [TARGET]
i3viswiz [--focus|-f] --instance|-i    [TARGET]
i3viswiz [--focus|-f] --class|-c       [TARGET]
i3viswiz [--focus|-f] --titleformat|-o [TARGET]
i3viswiz [--focus|-f] --winid|-d       [TARGET]
i3viswiz [--focus|-f] --parent|-p      [TARGET]
i3viswiz --help|-h
i3viswiz --version|-v

OPTIONS
-------

--gap|-g GAPSIZE  
Set GAPSIZE (defaults to 5). GAPSIZE is the
distance in pixels from the current window where
new focus will be searched.  


--focus|-f  
When used in conjunction with: --titleformat,
--title, --class, --instance, --winid or --parent.
The CON_ID of TARGET window will get focused if it
is visible.


--title|-t [TARGET]  
If TARGET matches the TITLE of a visible window,
that windows  CON_ID will get printed to stdout.
If no TARGET is specified, a list of all tiled
windows will get printed with  TITLE as the last
field of each row.


--instance|-i [TARGET]  
If TARGET matches the INSTANCE of a visible
window, that windows  CON_ID will get printed to
stdout. If no TARGET is specified, a list of all
tiled windows will get printed with  INSTANCE as
the last field of each row.


--class|-c [TARGET]  
If TARGET matches the CLASS of a visible window,
that windows  CON_ID will get printed to stdout.
If no TARGET is specified, a list of all tiled
windows will get printed with  CLASS as the last
field of each row.


--titleformat|-o [TARGET]  
If TARGET matches the TITLE_FORMAT of a visible
window, that windows  CON_ID will get printed to
stdout. If no TARGET is specified, a list of all
tiled windows will get printed with  TITLE_FORMAT
as the last field of each row.


--winid|-d [TARGET]  
If TARGET matches the WIN_ID of a visible window,
that windows  CON_ID will get printed to stdout.
If no TARGET is specified, a list of all tiled
windows will get printed with  WIN_ID as the last
field of each row.



--parent|-p [TARGET]  
If TARGET matches the PARENT of a visible window,
that windows  CON_ID will get printed to stdout.
If no TARGET is specified, a list of all tiled
windows will get printed with  PARENT as the last
field of each row.


--help|-h  
Show help and exit.


--version|-v  
Show version and exit.
EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

listvisible(){
  local type target gapsz

  type="$1"
  gapsz="$2"
  target="$3"

  i3-msg -t get_tree | awk -v RS=',' -F':' \
    -v opret="$type" \
    -v gapsz="$gapsz" \
    -v dir="$target"  '

    function listvis(id,achld,curc,c,schld,curs,s,stackh) {
      stackh=0

      if(ac[id]["layout"]=="stacked"){
        split(ac[id]["childs"],schld," ")
        for (s in schld) {
          curs=schld[s]
          gsub("[^0-9]","",curs)
          if(curs==""){continue}
          stackh++
        }
        stackh--
      }

      if(ac[id]["layout"]~/tabbed|stacked/){
        ac[id]["childs"]=ac[id]["focused"]}

      split(ac[id]["childs"],achld," ")
      for (c in achld) {
        curc=achld[c]
        gsub("[^0-9]","",curc)
        if(curc==""){continue}
        if(ac[id]["layout"]=="stacked"){
          ac[curc]["h"]=ac[curc]["h"]+(ac[curc]["b"]*stackh)
          ac[curc]["y"]=ac[curc]["y"]-(ac[curc]["b"]*stackh)
        }
        if (ac[curc]["childs"]!="")
          listvis(curc)
        else if (ac[curc]["f"]!=1)
          avis[curc]=curc
      }
    }

    BEGIN{focs=0;end=0;csid="first";actfloat=""}

    ac[cid]["counter"]=="go" && $1=="\"nodes\"" && $2!="[]"{
      ac[cid]["counter"]=csid
      csid=cid
    }

    $1~"{\"id\"" || $2~"\"id\"" {cid=$NF}

    $1=="\"layout\""{clo=$2}

    $1=="\"type\"" && $2=="\"workspace\"" {wsdchk="1"}
    wsdchk=="1" && $1=="\"width\""  {dim["w"]=$2}
    wsdchk=="1" && $1=="\"height\"" {gsub("}","",$2);dim["h"]=$2;wsdchk="2"}

    wsdchk=="1" && $(NF-1) ~ /"x"/ {dim["x"]=$NF}
    wsdchk=="1" && $(NF-1) ~ /"y"/ {dim["y"]=$NF}

    wsdchk=="2" && $1=="\"num\"" {
      dim[$2]["w"]=dim["w"]
      dim[$2]["h"]=dim["h"]
      dim[$2]["x"]=dim["x"]
      dim[$2]["y"]=dim["y"]
      wsdchk="0"
    }

    $1=="\"num\"" {cws=$2;cwsid=cid}

    $1=="\"focused\"" && $2=="true" {
      act=cid
      aws=cws
      awsid=cwsid
    }

    $1=="\"window\"" && $2=="null" {
      gsub("[\"]","",clo)
      ac[cid]["layout"]=clo
      ac[cid]["counter"]="go"
      ac[cid]["focused"]="X"
    }


    $1~"title_format" {ac[cid]["tf"]=$2}
    $1~"title" {ac[cid]["ttl"]=$2}
    $1=="\"window\"" {ac[cid]["wid"]=$2}
    # $1~"id" {ac[cid][]=$2}
    $1~"instance" {ac[cid]["ins"]=$2;ac[cid]["par"]=curpar}
    $1~"class" || $2~"class" {ac[cid]["cls"]=$NF}

    $1=="\"marks\"" {
      gsub("[[]|[]]|\"","",$2);
      if ($2 ~ /^i34.$/){
        sub("i34","",$2)
        curpar=$2
      }
    }


    $1=="\"window\"" && $2!="null" {
      ac[cid]["x"]=curx
      ac[cid]["y"]=cury
      ac[cid]["w"]=curw
      ac[cid]["h"]=curh
      ac[cid]["b"]=curb
    }

    $1=="\"rect\"" {curx=$3;rectw=1}
    rectw==1 && $1=="\"y\""{cury=$2}
    rectw==1 && $1=="\"width\""{curw=$2-1}
    rectw==1 && $1=="\"height\""{sub("}","",$2);curh=$2-1;rectw=2}

    $1=="\"deco_rect\"" {rectb=1}
    rectb==1 && $1=="\"height\""{
      sub("}","",$2)
      curh+=$2;cury-=$2
      curb=$2
      rectb=2
    }

    $1=="\"floating\"" && $2~"_on" {
      if(cid==act){actfloat="floating"}
      ac[cid]["f"]=1
    }

    $1=="\"focus\"" && $2!="[]" {focs=1}
    focs=="1" && $NF~"[]]$"{end=1}
    focs=="1" {
      gsub("[]]|[[]","",$NF)
      if(ac[csid]["focused"]=="X"){ac[csid]["focused"]=$NF}

      ac[csid]["childs"]=$NF" "ac[csid]["childs"]
    }

    end=="1" {
      csid=ac[csid]["counter"]
      focs=0;end=0
    }

    END{

      listvis(awsid)
      wall="none"

      wsh=int(dim[aws]["h"])
      wsw=int(dim[aws]["w"])
      wsx=int(dim[aws]["x"])
      wsy=int(dim[aws]["y"])

      if (dir=="r"){
        trgx=ac[act]["x"]+ac[act]["w"]+gapsz
        trgy=(gapsz+ac[act]["y"])+ac[act]["h"]/2

        if(trgx>(wsw+wsx)){
          trgx=gapsz
          wall="right"
        }
      }

      if (dir=="l"){
        trgx=ac[act]["x"]-gapsz
        trgy=(gapsz+ac[act]["y"])+ac[act]["h"]/2
        if(trgx<wsx){
          trgx=dim[aws]["w"]-gapsz
          wall="left"
        }
      }

      if (dir=="u"){
        trgx=(gapsz+ac[act]["x"])+ac[act]["w"]/2
        trgy=ac[act]["y"]-gapsz
        if(trgy<wsy){
          trgy=dim[aws]["h"]-gapsz
          wall="up"
        }
      }

      if (dir=="d"){
        trgx=(gapsz+ac[act]["x"])+ac[act]["w"]/2
        trgy=ac[act]["y"]+ac[act]["h"]+gapsz
        
        if(trgy>(wsh+wsy)){
          trgy=gapsz
          wall="down"
        }
      }

      trgx=int(trgx)
      trgy=int(trgy)

      if(actfloat==""){
        for (w in avis) {
          hit=0
          hity=0
          hitx=0
          xar=ac[w]["x"]+ac[w]["w"]
          if(trgx>=ac[w]["x"])
            if(xar>=trgx){++hitx;++hit}
          if(trgy>=ac[w]["y"] && trgy<=(ac[w]["y"]+ac[w]["h"]))
            {hity++;hit++}

          if (hit==2){
            tpar=ac[w]["par"]
            tcon=w
            break
          }

          
        }
      } 
      else
        tpar="floating"

      if (dir !~ /^[lrudX]$/) {
        for (w in avis) {
          if ((opret=="title" && ac[w]["ttl"] ~ dir) || 
            (opret=="class" && ac[w]["cls"] ~ dir) || 
            (opret=="parent" && ac[w]["par"] ~ dir) || 
            (opret=="instance" && ac[w]["ins"] ~ dir) || 
            (opret=="titleformat" && ac[w]["tf"] ~ dir) || 
            (opret=="winid" && ac[w]["wid"] ~ dir))
            {print w; exit}
        }
        exit
      }

      print \
        "trgcon=" tcon, "trgx=" trgx, "trgy=" trgy, \
        "wall=" wall, "trgpar=" tpar, \
        "sx=" dim[aws]["x"], \
        "sy=" dim[aws]["y"], \
        "sw=" dim[aws]["w"], \
        "sh=" dim[aws]["h"] 
      for (w in avis) {
        if(w==act)
          printf "* "
        else
          printf "- "

        printf w " "
        if (opret=="title"){tmpop="| " ac[w]["ttl"]}
        else if (opret=="class"){tmpop="| " ac[w]["cls"]}
        else if (opret=="parent"){tmpop="| " ac[w]["par"]}
        else if (opret=="instance"){tmpop="| " ac[w]["ins"]}
        else if (opret=="titleformat"){tmpop="| " ac[w]["tf"]}
        else if (opret=="winid"){tmpop="| " ac[w]["wid"]}
        else {tmpop=""}

        split("xywh",s,"")
        for (c in s)
          printf sprintf("%2s %-6s", s[c]":", ac[w][s[c]])
        gsub("[\"]","",tmpop)
        print tmpop 
      }
    }
  '
}
declare -A __o
eval set -- "$(getopt --name "i3viswiz" \
  --options "g:fticodphv" \
  --longoptions "gap:,focus,title,instance,class,titleformat,winid,parent,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --gap        | -g ) __o[gap]="${2:-}" ; shift ;;
    --focus      | -f ) __o[focus]=1 ;; 
    --title      | -t ) __o[title]=1 ;; 
    --instance   | -i ) __o[instance]=1 ;; 
    --class      | -c ) __o[class]=1 ;; 
    --titleformat | -o ) __o[titleformat]=1 ;; 
    --winid      | -d ) __o[winid]=1 ;; 
    --parent     | -p ) __o[parent]=1 ;; 
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


