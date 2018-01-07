
# Fyra is the Swedish name for "four" (4).

https://www.youtube.com/watch?v=kU8gb6WLFk8  
.  
https://www.youtube.com/watch?v=t4Tve-xpwus  
 
In the first video above I show the functionality of `i3fyra`. The second video is a longer and more thorough walkthrough on how to use `i3fyra`

## 18/01/03 i3flip
Tabswitching function (`-t`) is removed, use [i3flip](https://budrich.github.io/i3ass/i3flip) instead, it's both faster and works without **i3fyra**

## 17/12/20 update:    
I added the ability to pass more then one 
containers to `-z` (hide). All visible containers 
in the string will get hidden. If they are not visible nothing happens. If two of the requested containers are in the same *family/group* (AC|BD) the whole family will get hidden and *remembered*.
**Examples:**  
``` text
1. All four (ACBD) containers are visible:
$  i3fyra -z ABC

First the AC family will get hidden, then container C, leaving D as the sole visible container.

2. Container A and B is visible:
$  i3fyra -z DCB

Hides B container, ignores D and C and leaves A 
visible.

3. All four (ACBD) containers are visible:
$  i3fyra -z DCBA

First the AC family will get hidden, then BD 
leaving no visible containers.

4. ABC containers are visible, and container B 
   is active:
$  ALL_CONTAINERS="ABCD"
$  ACTIVE_CONTAINER=$(i3list | awk '{print $8}')
$  i3fyra -z ${ALL_CONTAINERS/$ACTIVE_CONTAINER}

The AC family will get hidden, leaving no the 
active container (B) alone.

A oneliner of the same thing could be written like this:  

$ i3fyra -z $(i3list | awk \
    '{all="ABCD";sub($8,"",all);print all}')
```

The last example is a *monocle mode* enabler.

`i3fyra` - An advanced simple gridbased tiling layout for i3wm. 

SYNOPSIS
--------
`i3fyra` [`OPTTION`] [`ARGUMENT`]

DESCRIPTION
-----------

The layout consists of four containers:  
``` text
  A B
  C D
```
The internal layout of the containers doesn't matter.  

A is always to the left of B and D. And always above C.  
B is always to the right of A and C. And always above D.  

This means that the containers will change names if their position changes.  

The size of the containers are defined by the three splits: AB, AC and BD.  
Container A and C are siblings and container B and D are siblings.  

If ABC are visible but D is hidden or none existent, layout becomes:  
``` text
  A B
  C B
```
If action: *move up* (`-m u`) would be called when B container is active 
and D is hidden. Container D would be shown. If action would have been:
*move down* (`-m d`), D would be shown and B and D would swap position and name.
If action would have been *move left* (`-m l`) the active window in B would be
moved to container A. If action was: *move right* (`-m r`) A and C would be hidden:
``` text
  B B
  B B
```
If we now call action: *move left* (`-m l`) A and C would be shown again but
to the right of B, the containers would also change names, so B becomes A, 
A becomes B and C becomes D:
``` text
  A B
  A D
```

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

`-s` *A|B|C|D*  
  Show target container. If it doesn't exist, it  
  will be created and current window will be put  
  in it. If it is visible, nothing happens.  

`-w` *i3list*  
  Use target i3list instead of getting a new list.

`-m` *A|B|C|D|u|d|l|r*  
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
         
`-z` *[ABCD]* 
  Hide target containers if visible. 

`-f` *u|d|l|r*
  Move focus in target direction. 

`-p` *INT*
  Distance in pixels to move a floating window. 
  Defaults to 30.

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

