# `i3fyra` - An advanced simple gridbased tiling layout for i3wm. 

SYNOPSIS
--------
`i3fyra` [`OPTTION`] [`ARGUMENT`]  

`i3fyra` `-m` A|B|C|D|u|r|d|l [`-p` INT]  
`i3fyra` `-s` A|B|C|D  
`i3fyra` `-z` [ABCD]  
`i3fyra` `-a`  
`i3fyra` `-l` LAYOUTSTRING

DESCRIPTION
-----------

The layout consists of four containers:  

``` text
  A B
  C D
```

A container can contain one or more windows.
The internal layout of the containers doesn't matter. 
By default the layout of each container is tabbed.  

A is always to the left of B and D. And always above C.  
B is always to the right of A and C. And always above D.  

This means that the containers will change names if 
their position changes.  

The size of the containers are defined by the three splits: 
AB, AC and BD.  

Container A and C belong to one family.  
Container B and D belong to one family.  

The visibility of containers and families can be toggled.
Not visible containers are placed on the scratchpad.  

The visibility is toggled by either using *show* (`-s`) or
*hide* (`-z`). But more often by moving a container in an
*impossible* direction, (*see examples below*).

The **i3fyra** layout is only active on one workspace.
That workspace can be set with the environment variable: 
`i3FYRA_WS`, otherwise the workspace active when the layout
is created will be used.  

The benefit of using this layout is that the placement of windows
is more predictable and easier to control. Especially when using
tabbed containers, which are very clunky to use with *default
i3*.

EXAMPLES
-------- 

If containers **A**,**B** and **C** are visible 
but **D** is hidden or none existent, the visible 
layout would looks like this:  

``` text
  A B
  C B
```

If action: *move up* (`-m u`) would be called when 
container **B** is active and **D** is hidden. 
Container **D** would be shown. If action would have 
been: *move down* (`-m d`), **D** would be shown 
but **B** would be placed below **D**, this means 
that the containers will also swap names. If action 
would have been *move left* (`-m l`) the active window 
in B would be moved to container **A**. If action was 
*move right* (`-m r`) **A** and **C** would be hidden:

``` text
  B B
  B B
```

If we now *move left* (`-m l`), **A** and **C** would 
be shown again but to the right of **B**, the containers 
would also change names, so **B** becomes **A**, **A** 
becomes **B** and **C** becomes **D**:

``` text
  A B
  A D
```

If this doesn't make sense, check out this demonstration
on youtube:  
https://youtu.be/kU8gb6WLFk8  


OPTIONS
-------

`-v`  
Show version info and exit.

`-h`  
Help, shows this info.

`-a`  
Autolayout. If current window is tiled: floating  
enabled If window is floating, it will be put in  
a visible container. If there is no visible  
containers. The window will be placed in a  
hidden container. If no containers exist,  
container 'A'will be created and  
the window will be put there.  

`-s` A|B|C|D  
Show target container. If it doesn't exist, it  
will be created and current window will be put  
in it. If it is visible, nothing happens.  

`-m` A|B|C|D|u|r|d|l [`-p` INT]  
Moves current window to target container, either 
defined by it's name or it's position relative 
to the current container with a direction: 
[`l`|`left`][`r`|`right`][`u`|`up`][`d`|`down`] 
If the container doesnt exist it is created. 
If argument is a direction and there is no 
container in that direction, Connected 
container(s) visibility is toggled. If current 
window is floating or not inside ABCD, normal 
movement is performed. Distance for moving 
floating windows with this action can be defined 
with the `-p` option.  
Example: `i3fyra -p 30 -m r`  
Will move current window 30 pixels to the right, 
if it is floating.

`-p` *INT*  
Distance in pixels to move a floating window. 
Defaults to 30.
         
`-z` *[ABCD]*   
Hide target containers if visible. 

`-l` *[AB=INT] [AC=INT] [BD=INT]*  
alter splits Changes the given splits. INT is a 
distance in pixels. AB is on X axis from the 
left side if INT is positive, from the right 
side if it is negative. AC and BD is on Y axis 
from the top if INT is positive, from the bottom 
if it is negative. The whole argument needs to 
be quoted. Example: `fyra -l 'AB=-300 BD=420'`

ENVIRONMENT
-----------

`I3FYRA_WS` *INT*  
Workspace to use for i3fyra. If not set, the firs
workspace that request to create the layout will
be used.

`I3FYRA_MAIN_CONTAINER` *[A|B|C|D]*  
This container will be the chosen when a container
is requested but not given. When using the command
autolayout (`-a`) for example, if the window is floating
it will be sent to the main container, if no other
containers exist. Defaults to A.

DEPENDENCIES
------------

i3wm  
i3list   
i3gw  
i3var  
i3viswiz   

