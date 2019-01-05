#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3run - version: 0.031
updated: 2019-01-05 by budRich
EOB
}



set -o errexit
set -o pipefail
set -o nounset

main(){

  if [[ -n ${__o[instance]} ]]; then
    acri=("-i" "${__o[instance]}")
  elif [[ -n ${__o[class]} ]]; then
    acri=("-c" "${__o[class]}")
  elif [[ -n ${__o[title]} ]]; then
    acri=("-t" "${__o[title]}")
  elif [[ -n ${__o[conid]} ]]; then
    acri=("-n" "${__o[conid]}")
  else
    ___printhelp
    ERX "please specify a criteria"
  fi

  declare -A i3list # globals array
  eval "$(i3list "${acri[@]}")"

  # if window doesn't exist, launch the command.
  [[ -z ${i3list[TWC]} ]] \
    && launchcommand \
    || focuswindow
}

___printhelp(){
  
cat << 'EOB' >&2
i3run - Run, Raise or hide windows in i3wm


SYNOPSIS
--------
i3run --help|-h
i3run --version|-v
i3run --instance|-i INSTANCE [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --class|-c CLASS [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --title|-t  TITLE [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --conid|-n CON_ID [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]

OPTIONS
-------

--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

--instance|-i INSTANCE  
Search for windows with the given INSTANCE


--summon|-s  
Instead of switching workspace, summon window to
current workspace


--nohide|-g  
Don't hide window/container if it's active.


--mouse|-m  
The window will be placed on the location of the
mouse cursor when it is created or shown. (needs
xdotool) 


--command|-e COMMAND  

--rename|-x  
If the search criteria is -i (instance), the
window with instance: OLDNAME will get a n new
instance name matching the criteria when it is
created (needs xdotool).


--class|-c CLASS  
Search for windows with the given CLASS


--title|-t TITLE  
Search for windows with the given TITLE


--conid|-n  
Search for windows with the given CON_ID

EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

focuswindow(){
  # if target window is active (current), 
  # send it to the scratchpad

  
  # else focus target window.
  if [[ ${i3list[AWC]} = "${i3list[TWC]}" ]]; then
    if ((${__o[nohide]:-0}!=1)); then

      if [[ -z ${i3list[TWP]} ]]; then
        # keep floating state in a var
        i3var set "hidden${i3list[TWC]}" "${i3list[TWF]}"
        i3-msg -q "[con_id=${i3list[TWC]}]" move scratchpad
      else
        # if it is handled by i3fyra and active
        # hide the container
        i3fyra -z "${i3list[TWP]}"
      fi
    fi
  else
    hvar="$(i3var get "hidden${i3list[TWC]}")"
    if [[ -n $hvar ]]; then
      ((hvar == 1)) && fs=enable || fs=disable
      # clear the variable
      i3var set "hidden${i3list[TWC]}"
    else
      ((i3list[TWF] == 1)) && fs=enable || fs=disable
    fi
    # window is not handled by i3fyra and not active
    if [[ -z ${i3list[TWP]} ]]; then
      if [[ ${i3list[WSA]} != "${i3list[WST]}" ]]; then
        if [[ ${i3list[WST]} = "-1" ]] || ((${__o[summon]:-0}==1)); then
          i3-msg -q "[con_id=${i3list[TWC]}]" \
            move to workspace "${i3list[WAN]}", \
            floating $fs
            i3-msg -q "[con_id=${i3list[TWC]}]" focus
            ((i3list[TWF] == 1)) && ((${__o[mouse]:-0}==1)) \
              && sendtomouse
        else
          i3-msg -q workspace "${i3list[WTN]}"
        fi
        
      fi
    else
      # window is handled by i3fyra and not active
      if [[ ${i3list[WSA]} != "${i3list[WST]}" ]]; then
        # window is not on current ws
        if [[ ${i3list[WSF]} = "${i3list[WSA]}" ]]; then
          # current ws is i3fyra WS
          [[ ${i3list[TWP]} =~ [${i3list[LHI]}] ]] \
            && i3fyra -s "${i3list[TWP]}"
        else
          # current ws is not i3fyra WS
          if [[ ${i3list[WST]} = "-1" ]] || ((${__o[summon]:-0}==1)); then
            i3-msg -q "[con_id=${i3list[TWC]}]" \
              move to workspace "${i3list[WAN]}", floating $fs
              i3-msg -q "[con_id=${i3list[TWC]}]" focus
              ((i3list[TWF] == 1)) && ((${__o[mouse]:-0}==1)) \
                && sendtomouse
          else
            i3-msg -q workspace "${i3list[WTN]}"
          fi
        fi
      fi
    fi
    i3-msg -q "[con_id=${i3list[TWC]}]" focus
  fi

  echo "${i3list[TWC]}"
}

launchcommand(){

  eval "${__o[command]}" > /dev/null 2>&1 & 

  [[ -n ${__o[rename]} ]] && {

    [[ ${acri[0]} = '-c' ]] && xdtopt=("--class")
    [[ ${acri[0]} = '-i' ]] && xdtopt=("--classname")
    [[ ${acri[0]} = '-t' ]] && xdtopt=("--name")

    xdtopt+=("${acri[1]}")

    xdotool set_window ${xdtopt[@]} `i3get ${acri[0]} "${__o[rename]}" -r d -y`
  }

  i3list[TWC]=$(i3get -y "${acri[@]}")
  
  ((i3list[TWF] == 1)) && ((${__o[mouse]:-0} == 1)) && {
    eval "$(i3list "${acri[@]}")"
    sendtomouse
  }

  sleep .2
  i3-msg -q "[con_id=${i3list[TWC]}]" focus
  echo "${i3list[TWC]}"
}

sendtomouse(){
  local X Y newy newx tmpx tmpy

  local breaky=$((i3list[WAH]-(I3RUN_BOTTOM_GAP+i3list[TWH])))
  local breakx=$((i3list[WAW]-(I3RUN_RIGHT_GAP+i3list[TWW])))

  eval "$(xdotool getmouselocation --shell)"

  local tmpy=$((Y-(i3list[TWH]/2)))
  local tmpx=$((X-(i3list[TWW]/2)))
  

  ((Y>(i3list[WAH]/2))) \
    && newy=$((tmpy>breaky
            ? breaky
            : tmpy)) \
    || newy=$((tmpy<I3RUN_TOP_GAP
            ? I3RUN_TOP_GAP
            : tmpy))

  ((X<(i3list[WAW]/2))) \
    && newx=$((tmpx<I3RUN_LEFT_GAP 
            ? I3RUN_LEFT_GAP 
            : tmpx)) \
    || newx=$((tmpx>breakx
            ? breakx 
            : tmpx))

  ((i3list[TWF] == 1)) \
    && i3-msg "[con_id=${i3list[TWC]}]" move absolute position $newx $newy
}
declare -A __o
eval set -- "$(getopt --name "i3run" \
  --options "hvi:sgme:xc:t:n" \
  --longoptions "help,version,instance:,summon,nohide,mouse,command:,rename,class:,title:,conid," \
  -- "$@"
)"

while true; do
  case "$1" in
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --summon     | -s ) __o[summon]=1 ;; 
    --nohide     | -g ) __o[nohide]=1 ;; 
    --mouse      | -m ) __o[mouse]=1 ;; 
    --command    | -e ) __o[command]="${2:-}" ; shift ;;
    --rename     | -x ) __o[rename]=1 ;; 
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --title      | -t ) __o[title]="${2:-}" ; shift ;;
    --conid      | -n ) __o[conid]=1 ;; 
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


