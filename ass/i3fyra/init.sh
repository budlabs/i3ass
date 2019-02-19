#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3fyra - version: 0.551
updated: 2019-02-19 by budRich
EOB
}


# environment variables
: "${I3FYRA_MAIN_CONTAINER:=A}"
: "${I3FYRA_WS:=1}"
: "${I3FYRA_ORIENTATION:=horizontal}"


___printhelp(){
  
cat << 'EOB' >&2
i3fyra - An advanced, simple grid-based tiling layout


SYNOPSIS
--------
i3fyra --show|-s CONTAINER
i3fyra --float|-a [--target|-t CRITERION]
i3fyra --hide|-z CONTAINER
i3fyra --layout|-l LAYOUT
i3fyra --move|-m DIRECTION|CONTAINER [--speed|-p INT]  [--target|-t CRITERION]
i3fyra --help|-h
i3fyra --version|-v

OPTIONS
-------

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


--hide|-z CONTAINER  
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


--help|-h  
Show help and exit.


--version|-v  
Show version and exit
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "i3fyra" \
  --options "s:at:z:l:m:p:hv" \
  --longoptions "show:,float,target:,hide:,layout:,move:,speed:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --show       | -s ) __o[show]="${2:-}" ; shift ;;
    --float      | -a ) __o[float]=1 ;; 
    --target     | -t ) __o[target]="${2:-}" ; shift ;;
    --hide       | -z ) __o[hide]="${2:-}" ; shift ;;
    --layout     | -l ) __o[layout]="${2:-}" ; shift ;;
    --move       | -m ) __o[move]="${2:-}" ; shift ;;
    --speed      | -p ) __o[speed]="${2:-}" ; shift ;;
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





