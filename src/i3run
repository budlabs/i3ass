#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3run - version: 0.089
updated: 2020-08-10 by budRich
EOB
}



main(){

  declare -a acri   # options passed to i3list
  declare -A i3list # globals array

  for k in instance class title conid ; do
    [[ -n ${__o[$k]} ]] \
      && acri=("--$k" "${__o[$k]}") && break
  done ; unset k

  [[ -z ${acri[*]} ]] \
    && ERH "please specify a criteria"

  _array=$(i3list "${acri[@]}")
  eval "$_array"

  # if window doesn't exist, launch the command.
  if [[ -z ${i3list[TWC]} ]]; then
    launchcommand
  else
    focuswindow
  fi
}

___printhelp(){
  
cat << 'EOB' >&2
i3run - Run, Raise or hide windows in i3wm


SYNOPSIS
--------
i3run --instance|-i INSTANCE [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --class|-c CLASS [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --title|-t  TITLE [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --conid|-n CON_ID [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --help|-h
i3run --version|-v

OPTIONS
-------

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


--rename|-x OLD_NAME  
If the search criteria is -i (instance), the
window with instance: OLDNAME will get a n new
instance name matching the criteria when it is
created (needs xdotool).  


   i3run --instance budswin --rename sublime_main -command subl
   
   # when the command above is executed:
   # a window with the instance name: "budswin" will be searched for.
   # if no window is found the command: "subl" will get executed,
   # and when a window with the instance name: "sublime_main" is found,
   # the instance name of that window will get renamed to: "budswin"





--force|-f  
Execute COMMAND (--command), even if the window
already exist. But not when hiding a window.


--FORCE|-F  
Execute COMMAND (--command), even if the window
already exist.


--command|-e COMMAND  
Command to run if no window is found. Complex
commands can be written inside quotes:  

   i3run -i sublime_text -e 'subl && notify-send "sublime is started"'




--class|-c CLASS  
Search for windows with the given CLASS


--title|-t TITLE  
Search for windows with the given TITLE


--conid|-n CON_ID  
Search for windows with the given CON_ID


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

focuswindow(){

  declare -i forcing hvar

  forcing=$((__o[FORCE]?2:__o[force]?1:0))
  
  # if target window is active (current), 
  if ((i3list[AWC] == i3list[TWC])); then
    
    # send it to the scratchpad
    if ((!__o[nohide])); then
      if [[ -z ${i3list[TWP]} ]]; then
        # keep floating state in a var
        i3-msg -q "[con_id=${i3list[TWC]}]" move scratchpad
        i3var set "hidden${i3list[TWC]}" "${i3list[TWF]}"
      else
        # if it is handled by i3fyra and active
        # hide the container
        i3fyra --force --hide "${i3list[TWP]}" --array "$_array"
      fi

     ((forcing == 2)) && [[ -n ${__o[command]} ]] \
       && eval "${__o[command]}" > /dev/null 2>&1 & 

    else

     ((forcing > 0)) && [[ -n ${__o[command]} ]] \
       && eval "${__o[command]}" > /dev/null 2>&1 &  
    fi

  else # focus target window.
    # hvar can contain floating state of target
    hvar=$(i3var get "hidden${i3list[TWC]}")
    if [[ -n $hvar ]]; then
      # windows need to be floating on scratchpad
      # so to "restore" a tiling window we do this
      ((hvar == 1)) && fs=enable || fs=disable
      # clear the variable
      i3var set "hidden${i3list[TWC]}"
    else
      ((i3list[TWF] == 1)) && fs=enable || fs=disable
    fi
    # target is not handled by i3fyra and not active
    # TWP - target window parent container name
    if [[ -z ${i3list[TWP]} ]]; then

      # target is not on active workspace
      if ((i3list[WSA] != i3list[WST])); then
        # WST == -1 , target window is on scratchpad
        if ((i3list[WST] == -1 || __o[summon])); then
          i3-msg -q "[con_id=${i3list[TWC]}]"   \
            move to workspace "${i3list[WAN]}", \
            floating $fs
            ((i3list[TWF] && __o[mouse])) && sendtomouse
        else
          i3-msg -q workspace "${i3list[WTN]}"
        fi
        
      fi
    else # window is handled by i3fyra and not active

      # window is not on current ws
      if ((i3list[WSA] != i3list[WST])); then

        # current ws is i3fyra WS
        if ((i3list[WSF] == i3list[WSA])); then
          # target window is in a hidden (LHI) container
          [[ ${i3list[TWP]} =~ [${i3list[LHI]}] ]] \
            && i3fyra --force --show "${i3list[TWP]}" --array "$_array"

        else # current ws is not i3fyra WS
          # WST == -1 , target window is on scratchpad
          if ((i3list[WST] == -1 || __o[summon])); then
            i3-msg -q "[con_id=${i3list[TWC]}]" \
              move to workspace "${i3list[WAN]}", floating $fs
              ((i3list[TWF] && __o[mouse])) && sendtomouse
          else # got to target windows workspace
            # WTN == name (string) of workspace
            i3-msg -q workspace "${i3list[WTN]}"
          fi
        fi
      fi
    fi

    i3-msg -q "[con_id=${i3list[TWC]}]" focus

   ((forcing > 0)) && [[ -n ${__o[command]} ]] \
     && eval "${__o[command]}" > /dev/null 2>&1 & 
  fi

  echo "${i3list[TWC]}"
}

launchcommand(){

  [[ -z ${__o[command]} ]] && ERX i3run no command, no action
  
  eval "${__o[command]}" > /dev/null 2>&1 &

  declare -a xdtopt # options passed to xdotool

  unset 'i3list[TWC]'

  [[ -n ${__o[rename]} ]] && {

    [[ ${acri[0]} = '--class'    ]] && xdtopt=("--class")
    [[ ${acri[0]} = '--instance' ]] && xdtopt=("--classname")
    [[ ${acri[0]} = '--title   ' ]] && xdtopt=("--name")

    xdtopt+=("${acri[1]}")

    xdotool set_window "${xdtopt[@]}" \
      "${i3list[TWC]:=$(i3get "${acri[0]}" "${__o[rename]}" -r d -y)}"
  }
  
  : "${i3list[TWC]:=$(i3get -y "${acri[@]}")}"
  
  ((__o[mouse])) && sendtomouse

  i3-msg -q "[con_id=${i3list[TWC]}]" focus
  echo "${i3list[TWC]}"
}

sendtomouse(){
  declare -i X Y newy newx tmpx tmpy breakx breaky

  eval "$(i3list "${acri[@]}")"

  i3-msg -q "[con_id=${i3list[TWC]}]" focus

  ((i3list[TWF])) && {
    breaky=$((i3list[WAH]-(I3RUN_BOTTOM_GAP+i3list[TWH])))
    breakx=$((i3list[WAW]-(I3RUN_RIGHT_GAP+i3list[TWW])))

    eval "$(xdotool getmouselocation --shell)"

    tmpy=$((Y-(i3list[TWH]/2)))
    tmpx=$((X-(i3list[TWW]/2))) 

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

    i3-msg -q "[con_id=${i3list[TWC]}]" \
      move absolute position $newx $newy
  }
}

declare -A __o
options="$(
  getopt --name "[ERROR]:i3run" \
    --options "i:sgmx:fFe:c:t:n:hv" \
    --longoptions "instance:,summon,nohide,mouse,rename:,force,FORCE,command:,class:,title:,conid:,help,version," \
    -- "$@" || exit 98
)"

eval set -- "$options"
unset options

while true; do
  case "$1" in
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --summon     | -s ) __o[summon]=1 ;; 
    --nohide     | -g ) __o[nohide]=1 ;; 
    --mouse      | -m ) __o[mouse]=1 ;; 
    --rename     | -x ) __o[rename]="${2:-}" ; shift ;;
    --force      | -f ) __o[force]=1 ;; 
    --FORCE      | -F ) __o[FORCE]=1 ;; 
    --command    | -e ) __o[command]="${2:-}" ; shift ;;
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --title      | -t ) __o[title]="${2:-}" ; shift ;;
    --conid      | -n ) __o[conid]="${2:-}" ; shift ;;
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


