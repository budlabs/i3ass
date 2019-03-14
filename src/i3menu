#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3menu - version: 0.02
updated: 2019-03-14 by budRich
EOB
}


# environment variables
: "${I3MENU_DIR:=$XDG_CONFIG_HOME/i3menu}"


main(){

  local listopts

  # globals
  __cmd="rofi -theme <(themefile) "

  # default includes
  : "${__o[include]:=pel}"

  # options to pass to i3list via --target optiob
  listopts=()
  [[ -n "${__o[target]:-}" ]] \
    && listopts=(${__o[target]:-})

  declare -A i3list
  eval "$(i3list "${listopts[@]}")"

  [[ -n ${__o[option]} ]] && __opts+=" ${__o[option]}"
  [[ -n ${__o[filter]} ]] && __cmd+="-filter '${__o[filter]}' "
  
  [[ -n ${__o[show]} ]] \
    && __opts+=" -show '${__o[show]}'" && __nolist=1
  [[ -n ${__o[modi]} ]] \
    && __opts+=" -modi '${__o[modi]}'" && __nolist=1

  if ((__nolist!=1)); then
    __opts+=" -dmenu"
    [[ -n $__stdin ]] && __list="${__stdin}"
  else
    __list=nolist
  fi

  setgeometry "${__o[layout]:-default}"
  setincludes

  if [[ -n $__list ]] && ((__nolist!=1));then
    printf '%s\n' "${__o[top]:-}" "__START" "${__list}" | awk '
    {
      if (start==1) {
        for (t in tops) {
          if ($0==tops[t]){tfnd[NR]=$0;topa[t]=$0} 
        }
        if (tfnd[NR]!=$0) {lst[NR]=$0}
      }
      if ($0=="__START") {start=1}
      if (start!=1) {tops[NR]=$0;nums++}
    }

    END {
      for (f in topa){if (topa[f]){print topa[f]}}
      for (l in lst){print lst[l]}
    }
    '
  fi | eval "${__cmd} ${__opts}"
}

___printhelp(){
  
cat << 'EOB' >&2
i3menu - Adds more features to rofi when used in i3wm


SYNOPSIS
--------
i3menu [--theme THEME] [--layout|-a LAYOUT] [--include|-i INCLUDESTRING] [--top|-t TOP] [--xpos|-x INT] [--xoffset INT] [--ypos|-y INT] [--yoffset INT] [--width|-w INT] [--options|-o OPTIONS] [--prompt|-p PROMPT]  [--filter|-f FILTER] [--show MODE] [--modi MODI] [--target TARGET] [--orientation ORIENTATION] [--anchor INT] [--height INT] [--fallback FALLBACK]
i3menu --help|-h
i3menu --version|-v

OPTIONS
-------

--theme THEME  
If a .rasi file with same name as THEME exist in
I3MENU_DIR/themes, it's content will get appended
to theme file before showing the menu.  

$ echo "list" | i3menu --theme red  
this will use the the file:
I3MENU_DIR/themes/red.rasi

If no matching themefile is found,
I3MENU_DIR/themes/default.rasi will be used  (and
created if it doesn't exist).


--layout|-a LAYOUT  
This is where i3menu differs the most from normal
rofi behavior and is the only option that truly
depends on i3, i3list (and i3fyra if the value is
A|B|C|D). If this option is not set, the menu will
default to a single line (dmenu like) menu at the
top of the screen. If however a value to this
option is one of the following:  

| LAYOUT     | menu location and dimensions 
|:-----------|:---------------
| mouse      | At the mouse position (requires xdotool)
| window     | The currently active window.
| titlebar   | The titlebar of the currently active window.
| tab        | The tab (or titlebar if it isn't tabbed) of the currently active window.
| A,B,C or D | The i3fyra container of the same name if it is visible. If target container isn't visible the menu will be displayed at the default location.


titlebar and tab LAYOUT will be displayed as a
single line (dmenu like) menu, and the other
LAYOUTS will be of vertical (combobox) layout with
the prompt and entrybox above the list.  

The position of the menu can be further
manipulated by using
--xpos,--ypos,--width,--height,--orientation,--include.  

$ echo "list" | i3menu --prompt "select: "
--layout window --xpos -50 --ypos 30  
The command above would create a menu with the
same size and position as the current window, but
place it 50px to the left of the window, and 30px
below the lower of the window.


--include|-i INCLUDESTRING  
INCLUDESTRING can be set to force which elements
of the menu to include. INCLUDESTRING can be one
or more of the following character:  

| char | element  |
|:-----|:---------|
|p | prompt   |
|e | entrybox |
|l | list     |


echo "list" | i3menu --include le --prompt "enter
a value: "  
The command above will result in a menu without
the prompt element.  

i3menu --include pe --prompt "enter a value: "  
The command above will result in a menu without a
list element. (just an inputbox).  

It's also worth mentioning that i3menu adapts to
the objects it knows before creating the menu.
This means that if no input stream (list) exist,
no list element will be included, the same goes
for the prompt.  


--top|-t TOP  
If TOP is set, the input stream (LIST) will get
matched against TOP. Lines in LIST with an exact
MATCH of those in TOP will get moved to the TOP of
LIST before the menu is created.


$ printf '%s\n' one two three four | i3menu --top
"$(printf '%s\n' two four)"  

will result in a list looking like this:  
two four one three



--xpos|-x INT  
Sets the X position of the menu to INT. If this
option is set, it will override any automatic
position of the X coordinate.


--xoffset INT  
Adds INT to the calculated X position of the menu
before it is displayed. XPOS can be either
positive or negative.

EXAMPLE  
If both --layout is set to window and --xpos is
set to -50, the menu will be placed 50 pixels to
the left of the active window but have the same
dimensions as the window.


--ypos|-y INT  
Sets the Y position of the menu to INT. If this
option is set, it will override any automatic
position of the Y coordinate.


--yoffset INT  
Adds INT to the calculated Y position of the menu
before it is displayed. INT can be either positive
or negative.

EXAMPLE  
If both --layout is set to titlebar and --ypos is
set to 50, the menu will be placed 50 pixels below
the active window.


--width|-w INT  
Changes the width of the menu. If the argument to
--width ends with a % character the width will be
that many percentages of the screenwidth. Without
% absolute width in pixels will be set.


--options|-o OPTIONS  
The argument is a string of aditional options to
pass to rofi.  

$ i3menu --prompt "Enter val: " --options
'-matching regex'  
will result in a call to rofi looking something
like this:  
rofi -p "Enter val: " -matching regex -dmenu

Note that the rofi options: -p, -filter, -show,
-modi could be entered to as arguments to i3menu
--options, but it is recommended to use: --prompt,
--filter, --show and --modi instead, since this
will make i3menu optimize the layout better.


--prompt|-p PROMPT  
Sets the prompt of the menu to PROMPT.


--filter|-f FILTER  
Sets the inputbox text/filter to FILTER. Defaults
to blank string.


--show MODE  
This is a short hand for the rofi option -show.
So instead of doing this:  
$ i3menu -o '-show run' , you can do this:  
$ i3menu --show run


--modi MODI  
This is a short hand for the rofi option -modi.
So instead of doing this:  
$ i3menu -o '-modi run,drun -show run' , you can
do this:  
$ i3menu --modi run,drun --show run


--target TARGET  
TARGET is a string containing additional options
passed to i3list. This can be used to change the
target window when --layout is set to:
window,titlebar or tab.


--orientation ORIENTATION  
This forces the layout of the menu to be either
vertical or horizontal. If --layout is set to
window, the layout will always be vertical.


--anchor INT  
Sets the "anchor" point of the menu. The default
is 1. 1 means the top left corner, 9 means the
bottom right corner. Corner in this context
doesn't refer to the corners of the screen, but
the corners of the menu. If the anchor is top left
(1), the menu will grow from that point.


--height INT  
Overrides the calculated height of the menu.


--fallback FALLBACK  
FALLBACK can be a string of optional options the
will be tried if the first layout fails. A layout
can fail of three reasons:

1. layout is window or container, but no list is passed. If no fallback is set, titlebar layout will get tried.
2. layout is container but container is not visible. If no fallback is set, default layout will get tried.
3. layout is window, tab or titlebar but no target window is found. If no fallback is set, default layout will get tried.


Example  

   $ echo -e "one\ntwo\nthree" | i3menu --layout A --fallback '--layout mouse --width 300'



The example above will display a menu at the
mouse pointer if container A isn't visible.

Fallbacks can be nested, but make sure to
alternate quotes:  


   $ echo -e "one\ntwo\nthree" | i3menu --layout A --fallback '--layout window --fallback "--layout mouse --width 300"'



The example above would first try to display a
menu with --layout A if that fails, it will try a
menu with --layout window and last if no target
window can be found, the menu will get displayed
at the mouse pointer.


--help|-h  
Show help and exit.


--version|-v  
Show version and exit
EOB
}


adjustposition() {
  local newy newx opty

  opty="${1:-0}"

  declare -A __menu

  eval "$(xdotool search --sync --classname rofi getwindowgeometry --shell | \
    awk -v FS='=' '{
      printf("__menu[%s]=%s\n",$1,$2)
    }'
  )"

  if ((__menu[X]<i3list[WAX])); then
    newx="${i3list[WAX]}"
  elif (((__menu[X]+__menu[WIDTH])>i3list[WAW])); then
    newx="$((i3list[WAW]-__menu[WIDTH]))"
  else
    newx=${__menu[X]}
  fi


  if ((opty<=-0)); then
    opty=$((i3list[WAH]-((opty*-1)+__menu[HEIGHT])))
  fi

  if ((opty<i3list[WAY])); then
    newy="${i3list[WAY]}"
  elif (((opty+__menu[HEIGHT])>i3list[WAH])); then
    newy="$((i3list[WAH]-__menu[HEIGHT]))"
  else
    newy="$opty"
  fi

  xdotool windowmove "${__menu[WINDOW]}" "$newx" "$newy"
}

createconf() {
local trgdir="$1"
declare -a aconfdirs

aconfdirs=(
"$trgdir/base"
"$trgdir/themes"
)

mkdir -p "${aconfdirs[@]}"

cat << 'EOCONF' > "$trgdir/base/i3menu.rasi"
/**
* Oneliner - by budRich 2018
* Based on dmenu theme by Dave Davenport
*/

#window {
  anchor:     @window-anchor;
  location:   north west;
  padding:    2px;

  width:     @window-width;
  height:    @window-height;
  x-offset:  @window-x;
  y-offset:  @window-y;
  children:  @window-content;
}

#horibox {
  orientation: horizontal;
  children:    @horibox-content;
}

#inputbar {
  children:   @inputbar-content;
}

#listview {
  layout:     @listview-layout;
  lines:      @listview-lines;
  spacing:    5px;
  dynamic:    true;
}

#entry {
  expand:     @entry-expand;
  width:      @entry-width;
}


#element {
  padding: 0px 2px;
}

#element selected {
  text-color: @selfg;
  background-color: @selbg;
}

#prompt {
  text-color: @promptfg;
  background-color: @promptbg;
}

// syntax:ssDslash
EOCONF

cat << 'EOCONF' > "$trgdir/base/themevars.rasi"
* {
  fg:          #988d6d;
  bg:          #FFFFD8;

  activefg:    #FFFFE8;
  activehl:    #424242;
  activebg:    #8888c8;

  inactivefg:  #988d6d;
  inactivebg:  #e8eb98;

  red:         #b85c57;
  green:       #40883f;
  blue:        #0287c8;
  yellow:      #989848;
  cyan:        #4fa8a8;
  magenta:     #8888c8;

  light:       #FFFFE8;
  dark:        #424242;

  fg2:         #B8B09A;
  comment:     #B8B09A;

  bg2:         #FFFFE8;

  selectedfg:  #FFFFE8;
  selectedbg:  #8888c8;

  font1: "FixedFixedsys 12";
}

EOCONF

cat << 'EOCONF' > "$trgdir/themes/dark.rasi"
*{
  background-color:    @dark;
  border-color:        @dark;
  text-color:          @light;
  selbg:               @light;
  selfg:               @dark;
  promptbg:            @light;
  promptfg:            @dark;
  font:                @font1; 
}
EOCONF

cat << 'EOCONF' > "$trgdir/themes/default.rasi"
*{
  background-color:    @bg2;
  border-color:        @bg2;
  text-color:          @fg;
  selbg:               @activebg;
  selfg:               @activefg;
  promptbg:            @bg2;
  promptfg:            @activehl;
  font:                @font1; 
}
EOCONF

cat << 'EOCONF' > "$trgdir/themes/light.rasi"
*{
  background-color:    @light;
  border-color:        @light;
  text-color:          @dark;
  selbg:               @dark;
  selfg:               @light;
  promptbg:            @dark;
  promptfg:            @light;
  font:                @font1; 
}
EOCONF

cat << 'EOCONF' > "$trgdir/themes/red.rasi"
*{
  background-color:    @red;
  border-color:        @red;
  text-color:          @light;
  selbg:               @dark;
  selfg:               @light;
  promptbg:            @light;
  promptfg:            @red;
  font:                @font1; 
}


EOCONF

}

ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

defaultoffset(){
  __xpos=0
  __ypos=0
  __o[xoffset]=0
  __o[yoffset]=0
  __o[width]="100%"
  __height=20
  __o[layout]=default
  __orientation=horizontal
  __anchor=1
}

setfallback(){

 __o[fallback]=""

 eval set -- "$(getopt --name "i3menu" \
   --options "a:i:t:x:y:w:o:p:f:" \
   --longoptions "theme:,layout:,include:,top:,xpos:,xoffset:,ypos:,yoffset:,width:,options:,prompt:,filter:,show:,modi:,target:,orientation:,anchor:,height:,fallback:" \
   -- "$@"
 )"

 while true; do
   case "$1" in
     --theme      ) __o[theme]="${2:-}" ; shift ;;
     --layout     | -a ) __o[layout]="${2:-}" ; shift ;;
     --include    | -i ) __o[include]="${2:-}" ; shift ;;
     --top        | -t ) __o[top]="${2:-}" ; shift ;;
     --xpos       | -x ) __o[xpos]="${2:-}" ; shift ;;
     --xoffset    ) __o[xoffset]="${2:-}" ; shift ;;
     --ypos       | -y ) __o[ypos]="${2:-}" ; shift ;;
     --yoffset    ) __o[yoffset]="${2:-}" ; shift ;;
     --width      | -w ) __o[width]="${2:-}" ; shift ;;
     --options    | -o ) __o[options]="${2:-}" ; shift ;;
     --prompt     | -p ) __o[prompt]="${2:-}" ; shift ;;
     --filter     | -f ) __o[filter]="${2:-}" ; shift ;;
     --show       ) __o[show]="${2:-}" ; shift ;;
     --modi       ) __o[modi]="${2:-}" ; shift ;;
     --target     ) __o[target]="${2:-}" ; shift ;;
     --orientation ) __o[orientation]="${2:-}" ; shift ;;
     --anchor     ) __o[anchor]="${2:-}" ; shift ;;
     --height     | -h ) __o[height]="${2:-}" ; shift ;;
     --fallback   ) __o[fallback]="${2:-}" ; shift ;;
     -- ) shift ; break ;;
     *  ) break ;;
   esac
   shift
 done 
}

setgeometry(){

  __layout="$1"

  # i3list[TWB]=20               # Target Window titlebar height
  # i3list[TWC]=94179890124352   # Target Window con_id
  # i3list[TTW]=257              # Target Window tab width
  # i3list[TTX]=0                # Target Window tab x postion
  # i3list[TWH]=220              # Target Window height
  # i3list[TWW]=514              # Target Window width
  # i3list[TWX]=0                # Target Window x position
  # i3list[TWY]=0                # Target Window y position
  # i3list[CAL]=tabbed           # Container A Layout
  # i3list[CBL]=tabbed           # Container B Layout
  # i3list[SAB]=514              # Current split: AB
  # i3list[SAC]=220              # Current split: AC
  # i3list[SBD]=220              # Current split: BD
  # i3list[SCD]=1080             # Current split: CD
  # i3list[LVI]=CBA              # Visible i3fyra containers
  # i3list[WAH]=1920             # Active Workspace height
  # i3list[WAW]=1080             # Active Workspace width
  # i3list[WAX]=0                # Active Workspace x position
  # i3list[WAY]=0                # Active Workspace y position

  # default geometry
  : "${__xpos:=${__o[xpos]:-0}}"
  : "${__ypos:=${__o[ypos]:-0}}"
  : "${__o[xoffset]:=0}"
  : "${__o[yoffset]:=0}"
  : "${__o[width]:="100%"}"
  : "${__height:=${__o[height]:-${i3list[TWB]:-20}}}"
  : "${__o[anchor]:=1}"
  : "${__orientation:=horizontal}"

  # if layout is window or container, but no list titlebar
  [[ $__layout =~ A|B|C|D|window ]] && [[ -z ${__list:-} ]] && {
    defaultoffset
    if [[ -n ${__o[fallback]:-} ]]; then
      __layout=fallback
      eval setfallback ${__o[fallback]}
      setgeometry "${__o[layout]:-default}"
      return
    else
      __layout=titlebar
    fi
  }

  # if layout is container but container is not visible
  [[ $__layout =~ A|B|C|D ]] && [[ ! ${i3list[LVI]} =~ [${__o[layout]}] ]] && {
    defaultoffset
    if [[ -n ${__o[fallback]:-} ]]; then
      __layout=fallback
      eval setfallback ${__o[fallback]}
      setgeometry "${__o[layout]:-default}"
      return
    else
      __layout=default
    fi
  }

  # if layout is window, tab or titlebar but no target window, default
  [[ $__layout =~ window|tab|titlebar ]] && [[ -z ${i3list[TWC]} ]] && {
    defaultoffset
    if [[ -n ${__o[fallback]:-} ]]; then
      __layout=fallback
      eval setfallback ${__o[fallback]}
      setgeometry "${__o[layout]:-default}"
      return
    else
      __layout=default
    fi
  }

  case "$__layout" in

    titlebar  ) 
      __ypos=$((i3list[TWY]+i3list[WAY]))
      __xpos=$((i3list[TWX]+i3list[WAX]))
      __o[width]=${i3list[TWW]}
      __height=${i3list[TWB]}
      __orientation=horizontal
    ;;

    window    )
        __xpos=$((i3list[TWX]+i3list[WAX]))
        __ypos=$((i3list[TWY]+i3list[WAY]))
        __o[width]=${i3list[TWW]}
        __height=${i3list[TWH]}
        __orientation=vertical
        __o[orientation]=""
    ;;

    bottom )
      __ypos=$((i3list[WAH]-i3list[AWB]))
    ;;

    tab       ) 
      if ((i3list[TTW]==i3list[TWW])); then
        __xpos=$((i3list[TWX]+i3list[WAX]))
        __o[width]=${i3list[TWW]}
      else
        __xpos=$((i3list[TTX]+i3list[TWX]))
        __o[width]=${i3list[TTW]}
      fi
      __ypos=$((i3list[TWY]+i3list[WAY]))
      __height=${i3list[TWB]}
      __orientation=horizontal
    ;;

    A|B|C|D ) 
      case "$__layout" in
        A) 
          __xpos=0
          __ypos=0
          __o[width]=${i3list[SAB]:-${i3list[WAW]}}
          __height=${i3list[SAC]:-${i3list[WAH]}}
        ;;

        B) 
          __xpos=${i3list[SAB]:-0}
          __ypos=0
          __o[width]=$((i3list[WAW]-__xpos))
          __height=${i3list[SBD]:-${i3list[SAC]:-${i3list[WAH]}}}
        ;;

        C) 
          __xpos=0
          __ypos=${i3list[SAC]:-0}
          __o[width]=${i3list[SCD]:-${i3list[SAB]:-${i3list[WAW]}}}
          __height=$((i3list[WAH]-__ypos))
        ;;

        D) 
          __xpos=${i3list[SCD]:-${i3list[SAB]:-0}}
          __ypos=${i3list[SBD]:-0}
          __o[width]=$((i3list[WAW]-__xpos))
          __height=$((i3list[WAH]-__ypos))
        ;;
      esac
      ((__height==0)) && __height="${i3list[WAH]}"
      ((__o[width]==0)) && __o[width]="${i3list[WAW]}"
      __orientation=vertical
      __o[orientation]=""
    ;;

    mouse )
      declare -A __mouse

      eval "$(xdotool getmouselocation --shell | \
        awk -v FS='=' '{
          printf("__mouse[%s]=%s\n",$1,$2)
        }'
      )"

      __xpos="$((__mouse[X]))"
      __ypos="$((__mouse[Y]))"
    ;;

  esac

  case ${__o[anchor]:=1} in
    1   ) __anchor="north west" ;;
    2   ) __anchor="north" ;;
    3   ) __anchor="north east" ;;
    4   ) __anchor="west" ;;
    5   ) __anchor="center" ;;
    6   ) __anchor="east" ;;
    7   ) __anchor="south west" ;;
    8   ) __anchor="south" ;;
    9   ) __anchor="south east" ;;
    *   ) __anchor="north west" ;;
  esac

  [[ -n ${__o[xpos]:-} ]] && {
    if ((__o[xpos]<0)) || ((__o[xpos]==-0)); then
      __xpos=$((i3list[WAW]-((__o[xpos]*-1)+__o[width])))
    else
      __xpos=${__o[xpos]}
    fi
  }

  ((__height<20)) && __height=20
  [[ -n ${__o[height]} ]] && __height="${__o[height]}"

  [[ -n ${__o[ypos]:-} ]] && __ypos=${__o[ypos]}

  [[ ${__o[xoffset]} =~ ^[0-9-]+$ ]] && __xpos=$((__xpos+__o[xoffset]))
  [[ ${__o[yoffset]} =~ ^[0-9-]+$ ]] && __ypos=$((__ypos+__o[yoffset]))

  [[ ${__o[width]} =~ [%]$ ]] || __o[width]=${__o[width]}px
  __height+="px"
}

setincludes(){
  local entry_expand entry_width listview_layout 
  local window_content horibox_content listview_lines

  [[ -n ${__o[prompt]:-} ]] \
    && __cmd+="-p ${__o[prompt]} " \
    || __o[include]=${__o[include]/[p]/}

  if [[ -z ${__list:-} ]]; then
    __o[include]=${__o[include]/[l]/}

    entry_expand=true
    entry_width=0

  else
    [[ -n ${__o[orientation]:-} ]] && {
      __orientation=${__o[orientation]}
      [[ $__orientation = vertical ]] && [[ -z ${__o[height]} ]] \
        && __height=0
    }
    listview_layout="$__orientation"
    ((__nolist!=1)) \
      && listview_lines="$(($(echo "${__list}" | wc -l)-1))"
  fi

  [[ ${__o[include]} =~ [p] ]] && inc+=(prompt)
  [[ ${__o[include]} =~ [e] ]] && inc+=(entry)

  if [[ $__orientation = vertical ]]; then
   
    __o[include]=${inc[*]}
    window_content="[ mainbox ]"
    inputbar_content="[${__o[include]//' '/','}]"
  else
    [[ ${__o[include]} =~ [l] ]] && inc+=(listview)
    __o[include]=${inc[*]}
    horibox_content="[${__o[include]//' '/','}]"
    window_content="[ horibox ]"
  fi

  if [[ $__layout = mouse ]] || { [[ $__ypos -lt 0 || $__ypos = -0 ]] && ((__o[anchor]<7)) ;}; then

    adjustposition "$__ypos" &
    
    # move window offscreen if:
    { 
      # negative ypos or xpos is outside of screen
      { [[ $__ypos -lt 0 || $__ypos = -0 ]] && ((__o[anchor]<7)) ;} || \
      ((__xpos+${__o[width]%px}>i3list[WAW]))

    } && __ypos=9999999

  fi 


  __themelayout="
  * {
    window-anchor:    ${__anchor:-north west};
    window-content:   ${window_content:-[horibox,listview]};
    horibox-content:  ${horibox_content:-[prompt, entry]};
    window-width:     ${__o[width]};
    window-height:    ${__height};
    window-x:         ${__xpos}px;
    window-y:         ${__ypos}px;
    listview-layout:  ${listview_layout:-horizontal};
    listview-lines:   ${listview_lines:-50};
    entry-expand:     ${entry_expand:-false};
    entry-width:      ${entry_width:-10em};
    inputbar-content: ${inputbar_content:-[prompt,entry]};
  }
  "
}

__=""
__stdin=""

read -N1 -t0.01 __  && {
  (( $? <= 128 ))  && {
    IFS= read -rd '' __stdin
    __stdin="$__$__stdin"
  }
}

themefile(){
  local themebase themefile themevars usrtheme

  usrtheme=${__o[theme]:-default}
  usrtheme="${usrtheme%.rasi}"

  themefile="${I3MENU_DIR}/themes/$usrtheme.rasi"
  themebase="${I3MENU_DIR}/base/i3menu.rasi"
  themevars="${I3MENU_DIR}/base/themevars.rasi"

  if [[ ! -f $themebase ]] || [[ ! -f $themevars ]]; then
    createconf "${I3MENU_DIR}"
  fi

  [[ -f $themefile ]] || {
    [[ -d ${I3MENU_DIR} ]] || createconf "${I3MENU_DIR}"
    themefile="${I3MENU_DIR}/themes/default.rasi"
  }

  echo "${__themelayout:-}"
  cat "$themevars" "$themefile" "$themebase"
}
declare -A __o
eval set -- "$(getopt --name "i3menu" \
  --options "a:i:t:x:y:w:o:p:f:hv" \
  --longoptions "theme:,layout:,include:,top:,xpos:,xoffset:,ypos:,yoffset:,width:,options:,prompt:,filter:,show:,modi:,target:,orientation:,anchor:,height:,fallback:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --theme      ) __o[theme]="${2:-}" ; shift ;;
    --layout     | -a ) __o[layout]="${2:-}" ; shift ;;
    --include    | -i ) __o[include]="${2:-}" ; shift ;;
    --top        | -t ) __o[top]="${2:-}" ; shift ;;
    --xpos       | -x ) __o[xpos]="${2:-}" ; shift ;;
    --xoffset    ) __o[xoffset]="${2:-}" ; shift ;;
    --ypos       | -y ) __o[ypos]="${2:-}" ; shift ;;
    --yoffset    ) __o[yoffset]="${2:-}" ; shift ;;
    --width      | -w ) __o[width]="${2:-}" ; shift ;;
    --options    | -o ) __o[options]="${2:-}" ; shift ;;
    --prompt     | -p ) __o[prompt]="${2:-}" ; shift ;;
    --filter     | -f ) __o[filter]="${2:-}" ; shift ;;
    --show       ) __o[show]="${2:-}" ; shift ;;
    --modi       ) __o[modi]="${2:-}" ; shift ;;
    --target     ) __o[target]="${2:-}" ; shift ;;
    --orientation ) __o[orientation]="${2:-}" ; shift ;;
    --anchor     ) __o[anchor]="${2:-}" ; shift ;;
    --height     ) __o[height]="${2:-}" ; shift ;;
    --fallback   ) __o[fallback]="${2:-}" ; shift ;;
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
  && __lastarg="" 


main "${@:-}"


