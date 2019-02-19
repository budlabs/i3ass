#!/usr/bin/env bash

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
