## 18/01/03 - new position to mouse

Floating windows now appears centered to the mouse position, but never outside the screen. Screen borders (gaps) can be fine tuned with environment variables. `xdotool` is a dependency now, it's needed to get the position of the mousecursor. All windows are now hidden if targeted while they are active, if not the new `-g` option is set. Using [i3var](https://budrich.github.io/i3ass/i3var) instead of marks.

* * *

`i3run` - Run, Raise or hide windows in i3wm

SYNOPSIS
--------

`i3run` `-h`|`-v`|`-i`|`-c`|`-t` [*CRITERIA*] [`-g`] [`-e` *COMMAND*]

DESCRIPTION
-----------

This is a run or raise or hide script for i3wm.
It looks for a window matching a given criteria.

These are the actions taken depending on the state of the found window:

| **target window state**          | **action**
|:---------------------------------|:-----------------
| Active and not handled by i3fyra | mark and hide
| Active and handled by i3fyra     | hide if not `-g` is set
| Handled by i3fyra and hidden     | show container, activate
| Not handled by i3fyra and hidden | show window, activate
| Not on current workspace         | goto workspace
| Not found                        | run command

Hidden in this context, means that window is on scratchpad/
Show in this context means, move window to current workspace.

OPTIONS
-------

`-v`  
  Show version info and exit 

`-h`  
  Show this help and exit    

`-c` *CLASS*  
  Search for windows with the given CLASS

`-i` *INSTANCE*  
  Search for windows with the given INSTANCE

`-t` *TITLE*  
  Search for windows with the given TITLE

`-e` *COMMAND*  
  Command to run if no window is found.

`-s`   
  Instead of switching workspace,
  summon window to current workspace

`-g`   
  Don't hide window/container if it's active.

it is important that `-e` *COMMAND* is last of the options.
`-e` is optional, if no *COMMAND* is passed and no window is found, nothing happens.
It is also important that *COMMAND* will spawn a window matching the criteria,
otherwise the script will get stuck in a loop waiting for the window to appear.

ENVIRONMENT
-----------

`I3RUN_BOTTOM_GAP` *INT*  
  Distance from the bottom edge of the screen to show floating windows.
  Defaults to 10.

`I3RUN_TOP_GAP` *INT*  
  Distance from the top edge of the screen to show floating windows.
  Defaults to 10.

`I3RUN_LEFT_GAP` *INT*  
  Distance from the left edge of the screen to show floating windows.
  Defaults to 10.

`I3RUN_RIGHT_GAP` *INT*  
  Distance from the right edge of the screen to show 
  floating windows. Defaults to 10.

`I3FYRA_WS` *INT*  
  Workspace to use for i3fyra. If not set, the first
  workspace that request to create the layout will
  be used.

DEPENDENCIES
------------

i3list
i3get
i3var
xdotool
