# `i3viswiz` - Professional window focus for i3wm

SYNOPSIS
--------

`i3viswiz` [`-v`|`-h`]  
`i3viswiz` [`-p` `t`|`c`|`i`|`n`|`o`|`d`]   
`i3viswiz` [`-g` *GAPSIZE*] [*DIRECTION*]  

DESCRIPTION
-----------

`i3viswiz` either prints a list of the currently visible
tiled windows to `stdout` or shifts the focus depending on
the arguments.  

If a *DIRECTION* (left|right|up|down) 
is passed, `i3wizvis` will shift the focus to the
window closest in the given DIRECTION, or warp
focus if there are no windows in the given direction.  

OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.

`-p`|`-t`|`-c`|`-i`|`-n`|`-o`|`-d`  
Print list of windows to `stdout`. The first line is either
the *con_id* of the window receiving focus . The second line 
are the x and y coordinates where receiving window is searched.
Remaining lines are the list. The first field is marked with a 
`*` if the line contains the active window.  

Depending on the option the last field of the output
contains different information about the window.

`-t` title  
`-c` class  
`-i` instance  
`-o` title_format  
`-n` con_id  
`-d` window_id  
`-p` parent container  

Floating windows are excluded from the list.
If the active window is floating, the first line
will have the text "floating".  

`-g` GAPSIZE  
Set GAPSIZE (defaults to 5). GAPSIZE is the distance in pixels
from the current window where new focus will be searched.  

*DIRECTION*  
Can be either (left|right|up|down) OR (l|r|u|d). DIRECTION needs
to be the last argument of the command. If no DIRECTION is given,
focus will not shift.  

EXAMPLE
-------

replace the normal i3 focus keybindings with viswiz 
like this:  
``` text
  Normal binding:
  bindsym Mod4+Shift+Left   focus left
  
  Wizzy binding:
  bindsym Mod4+Left   exec --no-startup-id i3viswiz l 
```  

example output:  
``` text
  $ i3viswiz -o -g 20 down
  target_con_id: 94851559487504
  tx: 582 ty: 470 wall: none
  * 94851560291216 x: 0     y: 0     w: 1165  h: 450   | URxvt
  - 94851559487504 x: 0     y: 451   w: 1165  h: 448   | sublime
  - 94851560318768 x: 1166  y: 0     w: 433   h: 899   | bin
```
