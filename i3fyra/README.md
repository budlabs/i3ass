
An advanced simple tiling layout for i3wm
=========================================
fyra is the Swedish name for "four".

https://www.youtube.com/watch?v=kU8gb6WLFk8  
In the video above I show the functionality of `i3fyra`

dependencies
------------
* [i3list](https://github.com/budRich/i3ass/tree/master/i3list)
* [i3gw](https://github.com/budRich/i3ass/tree/master/i3gw)

The layout consists of four containers:
``` shell
A B
C D
```
The internal layout of the containers doesn't matter.  
This means that container A could be tabbed and the others split horizontally for example.

A is always to the right of B and D. And always above C.
B is always to the left of A and C. And always above D.

This means that the containers will change names if their position changes.

The size of the containers are defined by the three splits: AB, AC and BD.
Container A and C are siblings and container B and D are siblings. 

If ABC are visible but D is hidden or none existent, layout becomes:
``` shell
A B
C B
```
If action: *move up* (-m u) would be called when B container is active 
and D is hidden. Container D would be shown. If action would have been:
*move down* (-m d), D would be shown and B and D would swap position and name.
If action would have been *move left* (-m l) the active window in B would be
moved to container A. If action was: *move right* (-m r) A and C would be hidden:
``` shell
B B
B B
```
If we now call action: *move left* (-m l) A and C would be shown again but
to the right of B, the containers would also change names, so B becomes A, 
A becomes B and C becomes D:
``` shell
A B
A D
```
usage
-----
`i3fyra [OPTTION] [ARGUMENT]`

``` shell
option | argument | action
--------------------------
-v     |          | Show version info and exit.

-h     |          | Help, shows this info.

-a     |          | Autolayout. If current window is tiled: floating enabled
                    If window is floating, it will be put in a visible container.
                    If there is no visible containers. The window will be placed
                    in a hidden container. If no containers exist, container 'A'
                    will be created and the window will be put there.

-s     | A|B|C|D  | Show target container. If it doesn't exist, it will be 
                    created and current window will be put in it.
                    If it is visible, nothing happens.

-w     | i3list   | Use target i3list instead of getting a new list.

-m     | A|B|C|D  | Moves current window to target container, either defined by
         u|d|l|r    it's name or it's position relative to the current container
                    with a direction: [l|left][r|right][u|up][d|down]
                    If the container doesnt exist it is created. If argument is
                    a direction and there is no container in that direction, 
                    Connected container(s) visibility is toggled.
                    If current window is floating or not inside ABCD, normal 
                    movement is performed. Distance for moving floating windows
                    with this action can be defined with the -p option. Example:
                    i3fyra -p 30 -m r
                    Will move current window 30 pixels to the right, 
                    if it is floating.
         
-z     | A|B|C|D  | Hide target container if it is visible, otherwise do nothing.

-f     | u|d|l|r  | move focus in target direction. 

-t     | u|d|l|r  | move focus inside current container (switch tabs). Autowarp.

-p     | INT      | Distance in pixels to move a floating window. Defaults to 30.

-l     | '[AB=INT] [AC=INT] [BD=INT]' | alter splits
                    Changes the given splits. INT is a distance in pixels.
                    AB is on X axis from the left side if INT is positive, from
                       the right side if it is negative.
                    AC and BD is on Y axis from the top if INT is positive, from
                       the bottom if it is negative.
                    The whole argument needs to be quoted. Example:
                    fyra -l 'AB=-300 BD=420'

```
