#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3list - version: 0.045
updated: 2019-02-19 by budRich
EOB
}



main(){

  local crit srch

  if [[ -z ${__o[*]:-} ]]; then
    crit=X srch=X
  elif [[ -n ${__o[instance]:-} ]]; then
    crit="instance" srch="${__o[instance]}"
  elif [[ -n ${__o[class]:-} ]]; then
    crit="class" srch="${__o[class]}"
  elif [[ -n ${__o[conid]:-} ]]; then
    crit="id" srch="${__o[conid]}"
  elif [[ -n ${__o[winid]:-} ]]; then
    crit="window" srch="${__o[winid]}"
  elif [[ -n ${__o[mark]:-} ]]; then
    crit="marks" srch="${__o[mark]}"
  elif [[ -n ${__o[title]:-} ]]; then
    crit="title" srch="${__o[title]}"
  else
    crit=X srch=X
  fi

  toprint="${1:-all}"
  printlist "$crit" "$srch" "$toprint"
  
}

___printhelp(){
  
cat << 'EOB' >&2
i3list - list information about the current i3 session.


SYNOPSIS
--------
i3list --instance|-i TARGET
i3list --class|-c    TARGET
i3list --conid|-n    TARGET
i3list --winid|-d    TARGET
i3list --mark|-m     TARGET
i3list --title|-t    TARGET
i3list --help|-h
i3list --version|-v

OPTIONS
-------

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

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


awklib() {
cat << 'EOB'
BEGIN {
  # sq contains a single quote for convenience
  sq = "'"
  
  # act|trg == 0: active/target window not found yet
  # act|trg == 1: active/target window in process
  # act|trg == 2: active/target window processed

  # hit !=0: inside i3fyra container

  act=trg=hit=0

  # set trg to processed if no criterion is given.
  # mirror active window to target before print.

  if (crit=="X") {trg=2}

  # define layout depending on orientation
  # splits[1] & splits[2] = families
  # splits[3] = main split
  
  if (ENVIRON["I3FYRA_ORIENTATION"]=="vertical") {
    splits[1]="AB"
    splits[2]="CD"
    splits[3]="AC"
  }
  else {
    splits[1]="AC"
    splits[2]="BD"
    splits[3]="AB" 
  }

  # fam array used to calculate relation between
  # containers in setfamily function.

  fam[1][1]   = substr(splits[1],1,1)
  fam[1][-1]  = substr(splits[1],2,1)
  fam[-1][1]  = substr(splits[2],1,1)
  fam[-1][-1] = substr(splits[2],2,1)

  # base layout array

  defaults[1]="A"
  defaults[2]="B"
  defaults[3]="C"
  defaults[4]="D"

}
function descriptions() {
  
  desc["CAS"]="Container A Status"
  desc["CAL"]="Container A Layout"
  desc["CAF"]="Container A Focused container id"
  desc["CBS"]="Container B Status"
  desc["CBL"]="Container B Layout"
  desc["CBF"]="Container B Focused container id"
  desc["CCS"]="Container C Status"
  desc["CCL"]="Container C Layout"
  desc["CCW"]="Container C Workspace"
  desc["CAW"]="Container A Workspace"
  desc["CBW"]="Container B Workspace"
  desc["CDW"]="Container D Workspace"
  desc["CCF"]="Container C Focused container id"
  desc["CDS"]="Container D Status"
  desc["CDL"]="Container D Layout"
  desc["CDF"]="Container D Focused container id"
  desc["SAB"]="Current split: AB"
  desc["SAC"]="Current split: AC"
  desc["SBD"]="Current split: BD"
  desc["SCD"]="Current split: CD"
  desc["MAB"]="Stored split: AB"
  desc["MAC"]="Stored split: AC"
  desc["MBD"]="Stored split: BD"
  desc["MCD"]="Stored split: CD"
  desc["FAC"]="Family AC memory"
  desc["FBD"]="Family BD memory"
  desc["FCD"]="Family CD memory"
  desc["LVI"]="Visible i3fyra containers"
  desc["LHI"]="Hidden i3fyra containers"
  desc["LAL"]="All containers in family order"
  desc["LEX"]="Existing containers (LVI+LHI)"

  desc["AWF"]="Active Window floating"
  desc["AWP"]="Active Window parent"
  desc["AWC"]="Active Window con_id"
  desc["AWI"]="Active Window id"
  desc["AFT"]="Active Window twin" 
  desc["AFC"]="Active Window cousin" 
  desc["AFS"]="Active Window sibling" 
  desc["AFF"]="Active Window family" 
  desc["AFO"]="Active Window relatives"
  desc["AWW"]="Active Window width"
  desc["AWH"]="Active Window height"
  desc["AWX"]="Active Window x position"
  desc["AWY"]="Active Window y position"
  desc["AWB"]="Active Window titlebar height"
  desc["ATX"]="Active Window tab x postion"
  desc["ATW"]="Active Window tab width"

  desc["TWF"]="Target Window Floating"
  desc["TWC"]="Target Window con_id"
  desc["TWI"]="Target Window id"
  desc["TWP"]="Target Window Parent container"
  desc["TFT"]="Target Window twin" 
  desc["TFC"]="Target Window cousin" 
  desc["TFS"]="Target Window sibling" 
  desc["TFF"]="Target Window family" 
  desc["TFO"]="Target Window relatives"
  desc["TTX"]="Target Window tab x postion"
  desc["TTW"]="Target Window tab width"
  desc["TWW"]="Target Window width"
  desc["TWH"]="Target Window height"
  desc["TWX"]="Target Window x position"
  desc["TWY"]="Target Window y position"
  desc["TWB"]="Target Window titlebar height"

  
  desc["WAW"]="Active Workspace width"
  desc["WAH"]="Active Workspace height"
  desc["WAX"]="Active Workspace x position"
  desc["WAY"]="Active Workspace y position"
  desc["WAN"]="Active Workspace name"
  desc["WSA"]="Active Workspace number"
  desc["WAI"]="Active Workspace con_id"
  desc["WST"]="Target Workspace Number"
  desc["WTN"]="Target Workspace name"
  desc["WTH"]="Target Workspace Height"
  desc["WTI"]="Target Workspace con_id"
  desc["WTW"]="Target Workspace Width"
  desc["WTX"]="Target Workspace X poistion"
  desc["WTY"]="Target Workspace Y position"
  desc["WSF"]="i3fyra Workspace Number"
  desc["WFH"]="i3fyra Workspace Height"
  desc["WFI"]="i3fyra Workspace con_id"
  desc["WFW"]="i3fyra Workspace Width"
  desc["WFX"]="i3fyra Workspace X position"
  desc["WFY"]="i3fyra Workspace Y position"
  desc["WFN"]="i3fyra Workspace name"

}
END {

  # mirror active to target if no criteria is given

  if (crit == "X") {
    for (k in window["A"]) {
      tk=k;sub("A","T",tk)
      if (!window["T"][tk]) {window["T"][tk]=window["A"][k]}
    }

    if (!workspace["WST"]) {setworkspace(workspace["WAI"],"T")}  
  }
  
  stringformat="i3list[%s]=%-15s\t# %s\n"
  descriptions()

  if (toprint ~ /^(all|active|window)$/) {
    for (k in window["A"]){
      printf(stringformat, k, window["A"][k], desc[k])
    }
  }

  
  if (toprint ~ /^(all|target|window)$/) {

    if (window["T"]["TWC"]) {
      for (k in window["T"]) {
        printf(stringformat, k, window["T"][k], desc[k])
      }
    }
  }


  # following block will only get printed if there is 
  # an i3fyra layout.

  if (workspace["WSF"]) {

    if (toprint ~ /^(all|container|i3fyra)$/) {
      for (k in container) {
        printf(stringformat, k, container[k], desc[k])
      }
    }

    for (k in defaults) {

      if (container["C" defaults[k] "W"]){
        if (container["C" defaults[k] "W"] == workspace["WSF"]){
          layout["LVI"]=defaults[k] layout["LVI"]
        } else {
          layout["LHI"]=defaults[k] layout["LHI"]
        }
      }

    }

    if (ENVIRON["I3FYRA_ORIENTATION"]=="vertical") {
    splits[1]="AB"
    splits[2]="CD"
    splits[3]="AC"
  }


    layout["LEX"]=layout["LVI"] layout["LHI"]

    if (ENVIRON["I3FYRA_ORIENTATION"]=="vertical") {
      # ac and bd is the same, height of a or b
      if (layout["LVI"] ~ "A") {
        outsplit["SAC"]=dim[acon["A"]]["window"]["height"]
      }
      else if (layout["LVI"] ~ "B") {
        outsplit["SAC"]=dim[acon["B"]]["window"]["height"]
      }
      else {
        outsplit["SAC"]=0
      }
      
      outsplit["SBD"]=outsplit["SAC"]
      outsplit["SAB"]=dim[acon["A"]]["window"]["width"]
      outsplit["SCD"]=dim[acon["C"]]["window"]["width"]
    } else {
      # ab and cd is the same, width of a or c
      if (layout["LVI"] ~ "A") {
        outsplit["SAB"]=dim[acon["A"]]["window"]["width"]
      }
      else if (layout["LVI"] ~ "C") {
        outsplit["SAB"]=dim[acon["C"]]["window"]["width"]
      }
      else {
        outsplit["SAB"]=0
      }

      outsplit["SCD"]=outsplit["SAB"]
      outsplit["SAC"]=dim[acon["A"]]["window"]["height"]
      outsplit["SBD"]=dim[acon["B"]]["window"]["height"]
    }

    if (layout["LVI"] ~ "[" splits[1] "]") {
      if (layout["LVI"] !~ "[" splits[2] "]") {outsplit["S"splits[3]]=0}
      if (layout["LHI"] ~ "[" splits[1] "]") {outsplit["S"splits[1]]=0}
    }

    if (layout["LVI"] ~ "[" splits[2] "]") {
      if (layout["LVI"] !~ "[" splits[1] "]") {outsplit["S"splits[3]]=0}
      if (layout["LHI"] ~ "[" splits[2] "]") {outsplit["S"splits[2]]=0}
    }
    
    if (toprint ~ /^(all|splits|i3fyra)$/) {
      for(k in outsplit){
        printf(stringformat, k, outsplit[k], desc[k])
      }
    }


    if (toprint ~ /^(all|layout|i3fyra)$/) {
      for(k in layout){
        printf(stringformat, k, layout[k], desc[k])
      }

      for(k in family){
        printf(stringformat, k, family[k], desc[k])
      }
    }
  }

  layout["LAL"]=splits[1] splits[2]
  printf(stringformat, "LAL", layout["LAL"], desc["LAL"])
  if (toprint ~ /^(all|workspace)$/) {
    for(k in workspace){
      printf(stringformat, k, workspace[k], desc[k])
    }
  }
}
hit!=0 && $0~"{" {hit++}
hit!=0 && $0~"}" {hit--}

$1 == "\"rect\"" && dimget != "workspace" {dimget="window"}
$1 == "\"deco_rect\"" {dimget="tab"}

match($0,/([{]|"nodes":[}][[]|.*_rect":{)?"([a-z_]+)":[["]*([^]}"]*)[]}"]*$/,ma) {
  key=ma[2]
  var=ma[3]

  if (trg == 0 && key == crit && var ~ srch) {
    if (key=="id") {curcid=var}
    window["T"]["TWC"]=curcid
    trg=1
  }

  switch (key) {
    case "focus":
      if (hit!=0) {
        container["C"curcon"F"]=var
      } else {
        # define active workspace by id
        # (only useful when workspace is empty)
        for (w in aws) {
          if (var == w) {
            setworkspace(w,"A")
          }
        }
      }
    break

    case "window":
      curwid=var
    break

    case "name":
      curnam=var
    break

    case "num":
      aws[curcid]["num"]=curws=var
      aws[curcid]["name"]=curwsnam=curnam
      curwsid=curcid
    break

    case /^(width|height|x|y)$/ :

      if (dimget != 0) {
        dim[curcid][dimget][key]=var
      }

      if (key == "height") {dimget=0}

    break

    case "id":
      curcid=var
      if (hit!=0) {conta[curcon]["id"]=curcid}
    break

    case "floating":
      if (curcid == window["A"]["AWC"] && act != 2) {
        setwindow(var,"A")
        act=2
      }

      if (curcid == window["T"]["TWC"] && trg != 2) {
        setwindow(var,"T")
        trg=2
      }
    break

    case "marks":

      if (var ~ /^i34[ABCD]$/) {
        hit=1
        curcon=substr(var,4,1)
        container["C"curcon"W"]=curws
        container["C"curcon"L"]="-"
        acon[curcon]=curcid
      }

      else if (var ~ /^i34X.*/ && fourspace != 1) {
        # if mainsplit container exist, get i3fyra
        # workspace on next occurrence of "num".

        setworkspace(curwsid,"F")
        fourspace=1
      }

      else if (var ~ /i34M(AB|CD|AC|BD)/) {
        split(var,mrksplt,"=")
        outsplit[substr(var,4,3)]=mrksplt[2]
      }

      else if (var ~ /i34F(AB|CD|AC|BD)/) {
        split(var,mrksplt,"=")
        family[substr(var,4,3)]=mrksplt[2]
      }

    break

    case "layout":
      if (hit!=0 && container["C"curcon"L"]=="-") {
        container["C"curcon"L"]=var
      }
    break

    case "focused":
      if (var == "true") {
        window["A"]["AWC"]=curcid
        act=1
      }
    break

  }
}
function setfamily(thiscon,type) {

  for (f in fam) {
    for (c in fam[f]) {
      if (fam[f][c] == thiscon) {
        window[type][type"FT"]=fam[f*-1][c]
        window[type][type"FC"]=fam[f*-1][c*-1]
        window[type][type"FS"]=fam[f][c*-1]
        window[type][type"FF"]=fam[f][1] fam[f][-1]
        window[type][type"FO"]=fam[f*-1][1] fam[f*-1][-1]
      }
    }
  }
}
function setwindow(floats,type) {

  if (floats ~ /on$/) 
    window[type][type"WF"]=1
  else
    window[type][type"WF"]=0

  setworkspace(curwsid,type)
  window[type][type"WI"]=curwid
  window[type][type"WX"]=dim[curcid]["window"]["x"]
  window[type][type"WB"]=dim[curcid]["tab"]["height"]
  window[type][type"WY"]=(dim[curcid]["window"]["y"]-window[type][type"WB"])
  window[type][type"WW"]=dim[curcid]["window"]["width"]
  window[type][type"WH"]=(dim[curcid]["window"]["height"]+window[type][type"WB"])
  window[type][type"TX"]=dim[curcid]["tab"]["x"]
  window[type][type"TW"]=dim[curcid]["tab"]["width"]

  if(curcid == conta[curcon]["id"]){

    window[type][type"WP"]=curcon
    setfamily(curcon,type)

  }
}
function setworkspace(cid,type) {
  workspace["WS"type]=aws[cid]["num"]
  workspace["W"type"I"]=cid
  workspace["W"type"N"]=sq aws[cid]["name"] sq
  workspace["W"type"W"]=dim[cid]["window"]["width"]
  workspace["W"type"H"]=dim[cid]["window"]["height"]
  workspace["W"type"X"]=dim[cid]["window"]["x"]
  workspace["W"type"Y"]=dim[cid]["window"]["y"]
}
EOB
}

ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

printlist(){

  local crit="${1:-X}"
  local srch="${2:-X}"
  local toprint="${3:-all}"

  i3-msg -t get_tree | awk -f <(awklib) \
                           -F':' \
                           -v RS=',' \
                           -v crit="${crit}" \
                           -v srch="${srch}" \
                           -v toprint="${toprint}" 
}
declare -A __o
eval set -- "$(getopt --name "i3list" \
  --options "i:c:n:d:m:t:hv" \
  --longoptions "instance:,class:,conid:,winid:,mark:,title:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --conid      | -n ) __o[conid]="${2:-}" ; shift ;;
    --winid      | -d ) __o[winid]="${2:-}" ; shift ;;
    --mark       | -m ) __o[mark]="${2:-}" ; shift ;;
    --title      | -t ) __o[title]="${2:-}" ; shift ;;
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


