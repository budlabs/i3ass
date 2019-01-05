#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3fyra - version: 0.544
updated: 2019-01-05 by budRich
EOB
}


# environment variables
: "${I3FYRA_MAIN_CONTAINER:=A}"
: "${I3FYRA_WS:=1}"
: "${I3FYRA_ORIENTATION:=horizontal}"


set -o errexit
set -o pipefail
set -o nounset

main(){
  local cmd target

  if [[ -n ${__o[show]} ]]; then
    cmd=containershow
    target="${__o[show]}"
  elif [[ -n ${__o[hide]} ]]; then
    cmd=containerhide
    target="${__o[hide]}"
  elif [[ -n ${__o[layout]} ]]; then
    cmd=applysplits
    target="${__o[layout]}"
  elif ((${__o[float]:-0}==1)); then
    cmd=togglefloat
  elif [[ -n ${__o[move]} ]]; then
    cmd=windowmove
    target="${__o[move]}"
  fi

  declare -A i3list # globals array
  eval "$(i3list ${__o[target]:-})"

  [[ -z ${i3list[WSF]} ]] \
    && i3list[WSF]=${I3FYRA_WS:-${i3list[WSA]}}

  i3list[CMA]=${I3FYRA_MAIN_CONTAINER:-A}

  ${cmd} "${target}" # run command

  [[ $cmd = windowmove ]] && [[ -z ${i3list[SIBFOC]} ]] \
      && i3-msg -q "[con_id=${i3list[AWC]}]" focus

  [[ $cmd = togglefloat ]] \
      && i3-msg -q "[con_id=${i3list[AWC]}]" focus

  [[ -n ${i3list[SIBFOC]} ]] \
    && i3-msg "[con_mark=i34${i3list[SIBFOC]}]" focus child
  
}

___printhelp(){
  
cat << 'EOB' >&2
i3fyra - An advanced, simple grid-based tiling layout


SYNOPSIS
--------
i3fyra --help|-h
i3fyra --version|-v
i3fyra --show|-s CONTAINER
i3fyra --float|-a [--target|-t CRITERION]
i3fyra --hide|-z CONTAINER(s)
i3fyra --layout|-l LAYOUT
i3fyra --move|-m DIRECTION|CONTAINER [--speed|-p INT]  [--target|-t CRITERION]

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v  
Show version and exit

--show|-s CONTAINER  
Show target container. If it doesn't exist, it
will be created and current window will be put in
it. If it is visible, nothing happens.


--float|-a  
Autolayout. If current window is tiled: floating
enabled If window is floating, it will be put in a
visible container. If there is no visible
containers. The window will be placed in a hidden
container. If no containers exist, container
'A'will be created and the window will be put
there.


--target|-t CRITERION  
Criteria is a string passed to i3list to use a
different target then active window. 

Example: 
$ i3fyra --move B --target "-i sublime_text" this
will target the first found window with the
instance name sublime_text. See i3list(1), for all
available options.


--hide|-z  
Hide target containers if visible.  


--layout|-l LAYOUT  
alter splits Changes the given splits. INT is a
distance in pixels. AB is on X axis from the left
side if INT is positive, from the right side if it
is negative. AC and BD is on Y axis from the top
if INT is positive, from the bottom if it is
negative. The whole argument needs to be quoted.
Example: 
$ i3fyra --layout 'AB=-300 BD=420' 



--move|-m CONTAINER  
Moves current window to target container, either
defined by it's name or it's position relative to
the current container with a direction:
[l|left][r|right][u|up][d|down] If the container
doesnt exist it is created. If argument is a
direction and there is no container in that
direction, Connected container(s) visibility is
toggled. If current window is floating or not
inside ABCD, normal movement is performed.
Distance for moving floating windows with this
action can be defined with the --speed option.
Example: $ i3fyra --speed 30 -m r Will move
current window 30 pixels to the right, if it is
floating.


--speed|-p INT  
Distance in pixels to move a floating window.
Defaults to 30.

EOB
}


applysplits(){
  local i tsn tsv par dir mrk

  for i in ${1}; do
    tsn="${i%\=*}" # target name of split
    tsv="${i#*\=}" # target value of split

    if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
      [[ $tsn = AC ]] \
        && par=${i3list[WSH]:-"${i3list[WAH]}"} dir=height mrk=i34XAB \
        || par=${i3list[WSW]:-"${i3list[WAW]}"} dir=width mrk=i34${tsn:0:1}
    else
      [[ $tsn = AB ]] \
        && par=${i3list[WSW]:-"${i3list[WAW]}"} dir=width mrk=i34XAC \
        || par=${i3list[WSH]:-"${i3list[WAH]}"} dir=height mrk=i34${tsn:0:1}
    fi

    ((tsv<0)) && tsv=$((par-(tsv*-1)))

    i3-msg -q "[con_mark=${mrk}]" resize set "$dir" "$tsv" px

    i3list[S${tsn}]=${tsv}
    i3var set "i34M${tsn}" ${tsv}

  done
}

___printversion(){
cat << 'EOB' >&2
i3fyra2 - version: 0.008
updated: 2018-10-19 by budRich
EOB
}

: "${I3FYRA_MAIN_CONTAINER:=A}"
: "${I3FYRA_WS:=1}"

___printhelp(){
cat << 'EOB' >&2
i3fyra2 - An advanced simple gridbased tiling layout

SYNOPSIS
--------

i3fyra2 --help|-h  
i3fyra2 --version|-v  
i3fyra2 --show|-s CONTAINER  
i3fyra2 --float|-a [--target|-t CRITERION]  
i3fyra2 --hide|-z CONTAINER(s)  
i3fyra2 --layout|-l LAYOUT  
i3fyra2 --move|-m DIRECTION|CONTAINER [--speed|-p INT]  [--target|-t CRITERION] 
 


DESCRIPTION
-----------

The layout consists of four containers:  


     A B
     C D


A container can contain one or more windows. The internal layout of the 
containers doesn't matter. By default the layout of each container is tabbed.  

A is always to the left of B and D. And always above C. B is always to the 
right of A and C. And always above D.  

This means that the containers will change names if their position changes.  

The size of the containers are defined by the three splits: AB, AC and BD.  

Container A and C belong to one family.  
Container B and D belong to one family.  

The visibility of containers and families can be toggled. Not visible 
containers are placed on the scratchpad.  

The visibility is toggled by either using show (-s) or hide (-z). But more 
often by moving a container in an impossible direction, (see examples below).  

The i3fyra layout is only active on one workspace. That workspace can be set 
with the environment variable: i3FYRA_WS, otherwise the workspace active when 
the layout is created will be used.  

The benefit of using this layout is that the placement of windows is more 
predictable and easier to control. Especially when using tabbed containers, 
which are very clunky to use with default i3.


OPTIONS
-------

--float|-a   
Autolayout. If current window is tiled: floating enabled If window is floating, 
it will be put in a visible container. If there is no visible containers. The 
window will be placed in a hidden container. If no containers exist, container 
'A'will be created and the window will be put there.

--help|-h   
Show help and exit.

--hide|-z CONTAINER(s)  
Hide target containers if visible.   

--layout|-l LAYOUT  
alter splits Changes the given splits. INT is a distance in pixels. AB is on X 
axis from the left side if INT is positive, from the right side if it is 
negative. AC and BD is on Y axis from the top if INT is positive, from the 
bottom if it is negative. The whole argument needs to be quoted. Example:  
$ i3fyra --layout 'AB=-300 BD=420'  

--move|-m CONTAINER  
Moves current window to target container, either defined by it's name or it's 
position relative to the current container with a direction: 
[l|left][r|right][u|up][d|down] If the container doesnt exist it is created. If 
argument is a direction and there is no container in that direction, Connected 
container(s) visibility is toggled. If current window is floating or not inside 
ABCD, normal movement is performed. Distance for moving floating windows with 
this action can be defined with the --speed option. Example: $ i3fyra --speed 
30 -m r Will move current window 30 pixels to the right, if it is floating.

--show|-s CONTAINER  
Show target container. If it doesn't exist, it will be created and current 
window will be put in it. If it is visible, nothing happens.

--speed|-p INT  
Distance in pixels to move a floating window. Defaults to 30.

--target|-t CRITERION  
Criteria is a string passed to i3list to use a different target then active 
window.  

Example:  
$ i3fyra --move B --target "-i sublime_text" this will target the first found 
window with the instance name sublime_text. See i3list(1), for all available 
options.

--version|-v   
Show version and exit


ENVIRONMENT
-----------

I3FYRA_MAIN_CONTAINER  
Defaults to: A  
This container will be the chosen when a container is requested but not given. 
When using the command autolayout (-a) for example, if the window is floating 
it will be sent to the main container, if no other containers exist. Defaults 
to A.

I3FYRA_WS  
Defaults to: 1  
Workspace to use for i3fyra. If not set, the firs workspace that request to 
create the layout will be used.

EXAMPLES
-------- 

If containers A,B and C are visible but D is hidden or none existent, the 
visible layout would looks like this:  


     A B
     C B


If action: move up (-m u) would be called when container B is active and D is 
hidden. Container D would be shown. If action would have been: move down (-m 
d), D would be shown but B would be placed below D, this means that the 
containers will also swap names. If action would have been move left (-m l) the 
active window in B would be moved to container A. If action was move right (-m 
r) A and C would be hidden:  


     B B
     B B


If we now move left (-m l), A and C would be shown again but to the right of B, 
the containers would also change names, so B becomes A, A becomes B and C 
becomes D:  


     A B
     A D


If this doesn't make sense, check out this demonstration on youtube: 
https://youtu.be/kU8gb6WLFk8

DEPENDENCIES
------------

bash  
gawk  
i3wm  
i3list  
i3gw  
i3var  
i3viswiz  
EOB
}

OFS="${IFS}"
IFS=$' \n\t'

declare -A __o
eval set -- "$(getopt --name "i3fyra2" \
  --options "hvs:t:z:m:l:p:a" \
  --longoptions "help,version,show:,target:,hide:,move:,layout:,speed:,float" \
  -- "$@"
)"

while true; do
  case "$1" in
    -v | --version ) ___printversion ; exit ;;
    -h | --help ) ___printhelp ; exit ;;
    -s | --show ) __o[show]="${2:-}" ; shift ;;
    -t | --target ) __o[target]="${2:-}" ; shift ;;
    -z | --hide ) __o[hide]="${2:-}" ; shift ;;
    -m | --move ) __o[move]="${2:-}" ; shift ;;
    -l | --layout ) __o[layout]="${2:-}" ; shift ;;
    -p | --speed ) __o[speed]="${2:-}" ; shift ;;
    -a | --float ) __o[float]=1 ;;
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" \
  || true

IFS="${OFS}"

for ___f in "${___dir}/lib"/*; do
  [[ ${___f##*/} =~ ^(bashbud|base) ]] && continue
  source "$___f"
done

containershow(){
  # show target ($1/trg) container (A|B|C|D)
  # if it already is visible, do nothing.
  # if it doesn't exist, create it 
  local trg sts tfam sib tdest famshow tmrk tspl tdim

  # trg = target container
  # sts = status (none|visible|hidden)

  trg=$1

  # trg is not legal
  [[ ! $trg =~ [${i3list[LAL]}] ]] && exit 1

  sts=none
  [[ $trg =~ [${i3list[LVI]}] ]] && sts=visible
  [[ $trg =~ [${i3list[LHI]}] ]] && sts=hidden

  case "$sts" in
    visible ) return ;;
    none    ) containercreate "$trg" ;;
    hidden  )
      
      # sib = sibling, tfam = family
      if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
        [[ $trg =~ [AB] ]] \
          && tfam=AB \
          || tfam=CD
      else
        [[ $trg =~ [AC] ]] \
          && tfam=AC \
          || tfam=BD
      fi

      sib=${tfam/$trg/}

      # if sibling is visible, tdest (destination)
      # otherwise XAB, main container
      if [[ ${sib} =~ [${i3list[LVI]}] ]]; then
        tdest="i34X${tfam}"
      elif [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
        tdest=i34XAC
      else
        tdest=134XAB
      fi
      
      # if if no containers are visible create layout
      if [[ -z ${i3list[LVI]} ]]; then
        layoutcreate "$trg"
      else
        # if tdest is XAB, trg is first in family
        if { [[ ${I3FYRA_ORIENTATION,,} = vertical ]] && [[ $tdest = i34XAC ]] ;}; then
          familycreate "$trg"
          famshow=1
        elif { [[ ${I3FYRA_ORIENTATION,,} != vertical ]] && [[ $tdest = i34XAB ]] ;}; then
          familycreate "$trg"
          famshow=1
        else
          echo "$tdest"
          # WSA = active workspace
          i3-msg -q "[con_mark=i34${trg}]" \
            move to workspace "${i3list[WSA]}", \
            floating disable, move to mark "$tdest"
        fi

        # swap - what to swap
        swap=()

        if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
          [[ $tdest = i34XAC ]] && [[ $sib =~ A|B ]] \
            && swap=("X$tfam" "X${i3list[LAL]/$tfam/}")

          [[ $tdest = i34X${tfam} ]] && [[ $sib =~ B|D ]] \
            && swap=("$trg" "${tfam/$trg/}")

          if [[ $tdest = i34XAC ]]; then
            tspl=${i3list[MAC]}  # stored split
            tdim=${i3list[WSH]}  # workspace width
            tmrk=AC
          else
            tspl=${i3list[M${tfam}]}
            tdim=${i3list[WSW]}      
            tmrk=$tfam 
          fi

          [[ ${#swap[@]} -gt 0 ]] && {
            i3-msg -q "[con_mark=i34${swap[0]}]" \
              swap container with mark i34${swap[1]}
          }

          [[ -n $tspl ]] \
            && { ((tdim==i3list[WSW])) || ((famact!=1)) ;} && {
              i3list[S${tmrk}]=$((tdim/2))
              eval "applysplits $tmrk=$tspl"
          }
        else
          [[ $tdest = i34XAB ]] && [[ $sib =~ A|C ]] \
            && swap=("X$tfam" "X${i3list[LAL]/$tfam/}")

          [[ $tdest = i34X${tfam} ]] && [[ $sib =~ C|D ]] \
            && swap=("$trg" "${tfam/$trg/}")

          if [[ $tdest = i34XAB ]]; then
            tspl=${i3list[MAB]}  # stored split
            tdim=${i3list[WSW]}  # workspace width
            tmrk=AB
          else
            tspl=${i3list[M${tfam}]}
            tdim=${i3list[WSH]}      
            tmrk=$tfam 
          fi

          [[ ${#swap[@]} -gt 0 ]] && {
            i3-msg -q "[con_mark=i34${swap[0]}]" \
              swap container with mark i34${swap[1]}
          }

          [[ -n $tspl ]] \
            && { ((tdim==i3list[WSH])) || ((famact!=1)) ;} && {
              i3list[S${tmrk}]=$((tdim/2))
              eval "applysplits $tmrk=$tspl"
          }
        fi
       
      fi

      i3list[LVI]+=$trg
      i3list[LHI]=${i3list[LHI]/$trg/}

      # bring the whole family
      [[ $famshow = 1 ]] && [[ $sib =~ [${i3list[LHI]}] ]] \
        && containershow "$sib"
    ;;
  esac
}

layoutcreate(){
  local trg fam

  trg=$1

  i3-msg -q workspace "${i3list[WSF]}"

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ $trg =~ A|B ]] && fam=AB || fam=CD 
    i3-msg -q "[con_mark=i34XAC]" unmark
  else
    [[ $trg =~ A|C ]] && fam=AC || fam=BD
    i3-msg -q "[con_mark=i34XAB]" unmark
  fi

  i3gw gurra  > /dev/null 2>&1
  
  i3-msg -q "[con_mark=gurra]" \
    split v, layout tabbed, focus parent
  i3-msg -q mark i34X${fam}, focus parent
  [[ ${I3FYRA_ORIENTATION,,} = vertical ]] \
    && i3-msg -q mark i34XAC \
    || i3-msg -q mark i34XAB
  
  i3-msg -q "[con_mark=i34${trg}]" \
    move to workspace "${i3list[WSA]}", \
    floating disable, \
    move to mark gurra

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    i3-msg -q "[con_mark=gurra]" layout splith, split h
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34XAC]" layout splitv, split v
  else
    i3-msg -q "[con_mark=gurra]" layout default, split v
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34XAB]" layout splith, split h
  fi

}

containercreate(){

  local trg=$1

  # error can't create container without window
  [[ -z ${i3list[TWC]} ]] && exit 1

  i3gw gurra  > /dev/null 2>&1
  i3-msg -q "[con_mark=gurra]" \
    split h, layout tabbed
  i3-msg -q "[con_id=${i3list[TWC]}]" \
    floating disable, move to mark gurra
  i3-msg -q "[con_mark=gurra]" \
    focus, focus parent
  i3-msg -q mark "i34${trg}"
  i3-msg -q "[con_mark=gurra]" kill
    
  # after creation, move cont to scratch
  i3-msg -q "[con_mark=i34${trg}]" focus, floating enable, \
    move absolute position 0 px 0 px, \
    resize set $((i3list[WSW]/2)) px $((i3list[WSH]/2)) px, \
    move scratchpad
  # add to trg to hid
  i3list[LHI]+=$trg
  # run container show to show container
  containershow "$trg"
}

familycreate(){
  local trg tfam ofam
  trg=$1

  if [[ $trg =~ A|C ]];then
    tfam=AC
    ofam=BD
  else
    ofam=AC
    tfam=BD
  fi

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    if [[ $trg =~ A|B ]];then
      tfam=AB
      ofam=CD
    else
      ofam=AB
      tfam=CD
    fi
  fi

  i3-msg -q "[con_mark=i34X${tfam}]" unmark
  i3gw gurra  > /dev/null 2>&1
  i3-msg -q "[con_mark=gurra]" \
    move to mark "i34X${ofam}", split v, layout tabbed

  i3-msg -q "[con_mark=i34${trg}]" \
    move to workspace "${i3list[WSA]}", \
    floating disable, \
    move to mark gurra
  i3-msg -q "[con_mark=gurra]" focus, focus parent
  i3-msg -q mark i34X${tfam}

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    i3-msg -q "[con_mark=gurra]" layout splith, split h
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34XAC]" layout splitv, split v
    i3-msg -q "[con_mark=i34X${tfam}]" move down
  else
    i3-msg -q "[con_mark=gurra]" layout default, split v
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34XAB]" layout splith, split h
    i3-msg -q "[con_mark=i34X${tfam}]" move right
  fi

}

ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

familyshow(){

  local fam=$1
  local tfammem="${i3list[F${fam}]}"
  # F${fam} - family memory

  famact=1
  for (( i = 0; i < ${#tfammem}; i++ )); do
    [[ ${tfammem:$i:1} =~ [${i3list[LHI]}] ]] \
      && containershow "${tfammem:$i:1}"
  done


  i3list[SAB]=$((i3list[WSW]/2))
  applysplits "AB=${i3list[MAB]}"

}

familyhide(){
  local tfam=$1
  local trg famchk tfammem i

  for (( i = 0; i < 2; i++ )); do
    trg=${tfam:$i:1}
    if [[ ${trg} =~ [${i3list[LVI]}] ]]; then
      i3-msg -q "[con_mark=i34${trg}]" focus, floating enable, \
        move absolute position 0 px 0 px, \
        resize set \
        "$((i3list[WSW]/2))" px \
        "$((i3list[WSH]/2))" px, \
        move scratchpad

      i3list[LHI]+=$trg
      i3list[LVI]=${i3list[LVI]/$trg/}

      famchk+=${trg}
    fi
  done

  i3var set "i34F${tfam}" "${famchk}"
  i3var set "i34MAB" "${i3list[SAB]}"
  i3var set "i34M${tfam}" "${i3list[S${tfam}]}"

}


containerhide(){
  local trg tfam famchk

  trg=$1

  [[ ${#trg} -gt 1 ]] && multihide "$trg" && return

  [[ $trg =~ A|C ]] && tfam=AC || tfam=BD
  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ $trg =~ A|B ]] && tfam=AB || tfam=CD
  fi

  i3-msg -q "[con_mark=i34${trg}]" focus, floating enable, \
    move absolute position 0 px 0 px, \
    resize set $((i3list[WSW]/2)) px $((i3list[WSH]/2)) px, \
    move scratchpad
  # add to trg to hid
  i3list[LHI]+=$trg
  i3list[LVI]=${i3list[LVI]/$trg/}
  i3list[LVI]=${i3list[LVI]:-X}

  # if trg is last of it's fam, note it.
  # else focus sib
  [[ ! ${tfam/$trg/} =~ [${i3list[LVI]}] ]] \
    && i3var set "i34F${tfam}" "$trg" \
    || i3list[SIBFOC]=${tfam/$trg/}

  # note splits
  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ -n ${i3list[SAC]} ]] && ((i3list[SAC]!=i3list[WSH])) && {
      i3var set "i34MAC" "${i3list[SAC]}"
      i3list[MAC]=${i3list[SAC]}
    }

    [[ -n ${i3list[S${tfam}]} ]] && ((${i3list[S${tfam}]}!=i3list[WSW])) && {
      i3var set "i34M${tfam}" "${i3list[S${tfam}]}" 
      i3list[M${tfam}]=${i3list[S${tfam}]}
    }
  else
    [[ -n ${i3list[SAB]} ]] && ((i3list[SAB]!=i3list[WSW])) && {
      i3var set "i34MAB" "${i3list[SAB]}"
      i3list[MAB]=${i3list[SAB]}
    }

    [[ -n ${i3list[S${tfam}]} ]] && ((${i3list[S${tfam}]}!=i3list[WSH])) && {
      i3var set "i34M${tfam}" "${i3list[S${tfam}]}" 
      i3list[M${tfam}]=${i3list[S${tfam}]}
    }
  fi
}

multihide(){
  local trg real i

  trg="$1"

  for (( i = 0; i < ${#trg}; i++ )); do
    [[ ${trg:$i:1} =~ [${i3list[LVI]}] ]] && real+=${trg:$i:1}
  done

  [[ -z $real ]] && return
  [[ ${#real} -eq 1 ]] && containerhide "$real" && return
  
  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ "A" =~ [$real] ]] && [[ "B" =~ [$real] ]] \
      && real=${real/A/} real=${real/B/} && familyhide AB
    [[ "C" =~ [$real] ]] && [[ "D" =~ [$real] ]] \
      && real=${real/C/} real=${real/D/} && familyhide CD
  else
    [[ "A" =~ [$real] ]] && [[ "C" =~ [$real] ]] \
      && real=${real/A/} real=${real/C/} && familyhide AC
    [[ "B" =~ [$real] ]] && [[ "D" =~ [$real] ]] \
      && real=${real/B/} real=${real/D/} && familyhide BD
  fi

  for (( i = 0; i < ${#real}; i++ )); do
    containerhide "${real:$i:1}"
  done
}

togglefloat(){
  local trg

  # AWF - 1 = floating; 0 = tiled
  if ((i3list[AWF]==1)); then

    # WSA != i3fyra && normal tiling
    if ((i3list[WSA]!=i3list[WSF])); then
      i3-msg -q [con_id="${i3list[AWC]}"] floating disable
      return
    fi

    # AWF == 1 && make AWC tiled and move AWC to trg
    if [[ ${i3list[CMA]} =~ [${i3list[LVI]}] ]]; then
      trg="${i3list[CMA]}" 
    elif [[ -n ${i3list[LVI]} ]]; then
      trg=${i3list[LVI]:0:1}
    elif [[ -n ${i3list[LHI]} ]]; then
      trg=${i3list[LHI]:0:1}
    else
      trg="${i3list[CMA]}"
    fi

    if [[ $trg =~ [${i3list[LEX]}] ]]; then
      containershow "$trg"
      i3-msg -q [con_id="${i3list[AWC]}"] floating disable, \
        move to mark "i34${trg}"
    else
      # if $trg container doesn't exist, create it
      containershow "$trg"
    fi
  else
    # AWF == 0 && make AWC floating
    i3-msg -q [con_id="${i3list[AWC]}"] floating enable
  fi
}

windowmove(){

  local dir=$1
  local trgcon wall trgpar ldir newcont

  # if dir is a container, show/create that container
  # and move the window there

  [[ $dir =~ A|B|C|D ]] && {
    
    [[ ! ${i3list[LEX]} =~ $dir ]] && newcont=1
    containershow "$dir"

    ((newcont!=1)) \
      && i3-msg -q "[con_id=${i3list[TWC]}]" \
           focus, floating disable, \
           move to mark "i34${dir}"

    exit

  }

  # else make sure direction is lowercase u,l,d,r

  dir=${dir,,}
  dir=${dir:0:1}

  # "exit if $dir not valid"
  [[ ! $dir =~ u|r|l|d ]] \
    && ERX "$dir not a valid direction."

  case $dir in
    l ) ldir=left  ;;
    r ) ldir=right ;;
    u ) ldir=up    ;;
    d ) ldir=down  ;;
  esac

  # if window is floating, move with i3Kornhe
  ((i3list[AWF]==1)) && { i3Kornhe m $ldir; exit ;}

  # get visible info from i3viswiz
  # trgcon is the container currently at target pos
  # trgpar is the parent of trgcon (A|B|C|D)

  eval "$(i3viswiz -p "$dir" | head -1)"

  if [[ $wall != none ]]; then

    # sibling toggling
    if [[ $dir =~ u|d ]]; then
      if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
        # if relatives is visible, hide 'em
        if [[ ${i3list[LVI]} =~ [${i3list[AFO]}] ]]; then
          familyhide "${i3list[AFO]}"
        else
            # else show container, add to swap
            familyshow "${i3list[AFO]}"
            {
              { [[ $dir = u ]] && [[ ${i3list[AFO]} = AB ]] ; } || \
              { [[ $dir = d ]] && [[ ${i3list[AFO]} = CD ]] ; }
            } && toswap=("i34X${i3list[AFO]}" "i34X${i3list[AFF]}")
        fi
      else
        # if sibling is visible, hide it
        [[ ${i3list[AFS]} =~ [${i3list[LVI]}] ]] \
          && containerhide "${i3list[AFS]}" || {
            # else show container, add to swap
            containershow "${i3list[AFS]}"
            {
              { [[ $dir = u ]] && [[ ${i3list[AFS]} =~ [AB] ]] ; } || \
              { [[ $dir = d ]] && [[ ${i3list[AFS]} =~ [CD] ]] ; }
            } && toswap=("i34${i3list[AFS]}" "i34${i3list[AWP]}")
          }
      fi

    # family toggling
    elif [[ $dir =~ l|r ]]; then
      if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
        # if sibling is visible, hide it
        [[ ${i3list[AFS]} =~ [${i3list[LVI]}] ]] \
          && containerhide "${i3list[AFS]}" || {
            # else show container, add to swap
            containershow "${i3list[AFS]}"
            {
              { [[ $dir = l ]] && [[ ${i3list[AFS]} =~ [AC] ]] ; } || \
              { [[ $dir = r ]] && [[ ${i3list[AFS]} =~ [BD] ]] ; }
            } && toswap=("i34${i3list[AFS]}" "i34${i3list[AWP]}")
          }
      else
        # if relatives is visible, hide 'em
        if [[ ${i3list[LVI]} =~ [${i3list[AFO]}] ]]; then
          familyhide "${i3list[AFO]}"
        else
            # else show container, add to swap
            familyshow "${i3list[AFO]}"
            {
              { [[ $dir = l ]] && [[ ${i3list[AFO]} = AC ]] ; } || \
              { [[ $dir = r ]] && [[ ${i3list[AFO]} = BD ]] ; }
            } && toswap=("i34X${i3list[AFO]}" "i34X${i3list[AFF]}")
        fi
      fi
    fi
    
    [[ -n ${toswap[1]} ]] \
      && swapmeet "${toswap[0]}" "${toswap[1]}" \
      && i3-msg -q "[con_id=${i3list[TWC]}]" focus

  else
    # trgpar is visible, if layout is tabbed just move it
    if [[ ${i3list[C${trgpar}L]} =~ tabbed|stacked ]]; then
      
      i3-msg -q "[con_id=${i3list[TWC]}]" \
        focus, floating disable, \
        move to mark "i34${trgpar}", focus

        
    elif [[ ${i3list[C${trgpar}L]} =~ splitv|splith ]]; then
      # target and current container is the same, move normaly
      if [[ $trgpar = "${i3list[TWP]}" ]]; then
        i3-msg -q "[con_id=${i3list[TWC]}]" move "$ldir"

      # move below/to the right of the last child of the container  
      elif [[ $dir =~ l|u ]]; then
        i3-msg -q "[con_id=${i3list[TWC]}]" \
          move to mark "i34${trgpar}", focus

      # move above/to the left of target container
      else
        i3-msg -q "[con_id=${trgcon}]" mark i34tmp
        i3-msg -q "[con_id=${i3list[TWC]}]" \
          move to mark "i34tmp", swap mark i34tmp
        i3-msg -q "[con_id=${trgcon}]" unmark
      fi
    fi
  fi
}

swapmeet(){
  local m1=$1
  local m2=$2
  local i k cur
  
  # array with containers (k=current name, v=twin name)
  declare -A acn 

  i3-msg -q "[con_mark=${m1}]"  swap mark "${m2}", mark i34tmp
  i3-msg -q "[con_mark=${m2}]"  mark "${m1}"
  i3-msg -q "[con_mark=i34tmp]" mark "${m2}"

  # if targets are families, remark all containers 
  # with their twins
  if [[ $m1 =~ X ]]; then
    if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
      tspl="${i3list[SAC]}" tdim="${i3list[WSH]}"
      tmrk=AC
    else
      tspl="${i3list[SAB]}" tdim="${i3list[WSW]}"
      tmrk=AB
    fi
  else
    tmrk="${i3list[AFF]}"
    tspl="${i3list[S${tmrk}]}"
    [[ ${I3FYRA_ORIENTATION,,} = vertical ]] \
      && tdim="${i3list[WSW]}" \
      || tdim="${i3list[WSH]}"
  fi

  { [[ -n $tspl ]] || ((tspl != tdim)) ;} && {
    # invert split
    tspl=$((tdim-tspl))
    eval "applysplits '$tmrk=$tspl'"
  }

  # family swap, rename all existing containers with their twins
  if [[ $m1 =~ X ]]; then 
    for (( i = 0; i < ${#i3list[LEX]}; i++ )); do
      cur=${i3list[LEX]:$i:1}
      if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
        case $cur in
          A ) acn[$cur]=C ;;
          B ) acn[$cur]=D ;;
          C ) acn[$cur]=A ;;
          D ) acn[$cur]=B ;;
        esac
      else
        case $cur in
          A ) acn[$cur]=B ;;
          B ) acn[$cur]=A ;;
          C ) acn[$cur]=D ;;
          D ) acn[$cur]=C ;;
        esac
      fi
      i3-msg -q "[con_mark=i34${cur}]" mark "i34tmp${cur}"
    done
    for k in "${!acn[@]}"; do
      i3-msg -q "[con_mark=i34tmp${k}]" mark "i34${acn[$k]}"
    done
    if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
      i3var set i3MAB "${i3list[MBD]}"
      i3var set i3MCD "${i3list[MAC]}"
    else
      i3var set i3MAC "${i3list[MBD]}"
      i3var set i3MBD "${i3list[MAC]}"
    fi
  else # swap within family, rename siblings
    for (( i = 0; i < ${#i3list[AFF]}; i++ )); do
      cur=${i3list[AFF]:$i:1}
      if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
        case $cur in
          A ) acn[$cur]=B ;;
          B ) acn[$cur]=A ;;
          C ) acn[$cur]=D ;;
          D ) acn[$cur]=C ;;
        esac
      else
        case $cur in
          A ) acn[$cur]=C ;;
          B ) acn[$cur]=D ;;
          C ) acn[$cur]=A ;;
          D ) acn[$cur]=B ;;
        esac
      fi
      i3-msg -q "[con_mark=i34${cur}]" mark "i34tmp${cur}"
    done
    for k in "${!acn[@]}"; do
      i3-msg -q "[con_mark=i34tmp${k}]" mark "i34${acn[$k]}"
    done
  fi

}
declare -A __o
eval set -- "$(getopt --name "i3fyra" \
  --options "hvs:at:zl:m:p:" \
  --longoptions "help,version,show:,float,target:,hide,layout:,move:,speed:," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    --show       | -s ) __o[show]="${2:-}" ; shift ;;
    --float      | -a ) __o[float]=1 ;; 
    --target     | -t ) __o[target]="${2:-}" ; shift ;;
    --hide       | -z ) __o[hide]=1 ;; 
    --layout     | -l ) __o[layout]="${2:-}" ; shift ;;
    --move       | -m ) __o[move]="${2:-}" ; shift ;;
    --speed      | -p ) __o[speed]="${2:-}" ; shift ;;
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


