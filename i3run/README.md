# `i3run` - Run, Raise or hide windows in i3wm

SYNOPSIS
--------

`i3run` `-h`|`-v`  
`i3run` `-i`|`-c`|`-t` [*CRITERIA*] [`-g`] [`-m`] [`-s`] [`-x` *OLDNAME*] [`-e` *COMMAND*]

DESCRIPTION
-----------

`i3run` let' you use one command for multiple
functions related to the same window identified by a
given criteria, (*see options below*).  

`i3run` will take different action depending on
the state of the searched window:   

| **target window state**          | **action**
|:---------------------------------|:-----------------
| Active and not handled by i3fyra | hide
| Active and handled by i3fyra     | hide container, if not `-g` is set
| Handled by i3fyra and hidden     | show container, activate
| Not handled by i3fyra and hidden | show window, activate
| Not on current workspace         | goto workspace or show if `-s` is set
| Not found                        | execute command (`-e`)

Hidden in this context, means that window is on the scratchpad.
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

`-m`  
The window will be placed on the location of the mouse
cursor when it is created or shown. (*needs `xdotool`*)

`-x` *OLDNAME*  
If the search criteria is `-i` (instance), the window with
instance: *OLDNAME* will get a n new instance name matching
the criteria when it is created (*needs `xdotool`*).

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

OPTIONAL
--------  

xdotool  
i3fyra
