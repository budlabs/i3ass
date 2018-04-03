## 18/01/03 - window geometry

Added some new output values (45-55) to return the window geometry.
Also AWM/TWM (mark) is deprecated, since spaces in marks caused trouble.

* * *

`i3list` - List attributes of i3wm

SYNOPSIS
--------

`i3list` [`OPTION` [*CRITERIA*]]

DESCRIPTION
-----------

This script is vital for i3fyra to work. But it can be used on it's own
or with other scripts. `i3list` is also used by i3run. `i3list` parses the
output of the command:  
`i3-msg -t get_tree`  

and returns a long string with 43 values separated by spaces. This strange 
output format is made to make it possible to pipe the output to other scripts. 
A lot of the information is specific to i3fyra, but if `i3list` doesn't find a 
value an X will be placed in it's place in the output.  

The idea, is to use this script once, and get all the info about i3's current
state in one big chunk. So one doesn't have to make more requests for 
tree output. It have speeded up my own scripts a lot. And it also makes many
listener scripts unnecessary. The parsing is done with awk, and it is very
fast, about 25ms on my average computer (i5, 4GB). Same operation with pure
bash would take at least a whole second (x40).  

I have made another script, `i3get`, that works in a similar way but where you
choose which information you want in the output. `i3get` is slightly faster (5ms),
but `i3list` outputs more information and is meant to replace multiple `i3get` requests.

OPTIONS
-------

`-v` 
  Show version info and exit

`-h` 
  Show this help and exit

`-c` *CLASS*
  Search for windows with the given *CLASS*

`-i` *INSTANCE*
  Search for windows with the given *INSTANCE*

`-t` *TITLE*
  Search for windows with the given *TITLE*

`-n` *CON_ID*
  Search for windows with the given *CON_ID*

`-d` *WINDOW_ID*
  Search for windows with the given *WINDOW ID*

`-m` *CON_MARK*
  Search for windows with the given *CON_MARK*

If no option is passed, active window will be target.

**example output**
``` text
$ i3list
  1 ABD C ABDC g u a X 1 94834554562528 f-94834554562528 g u a X 1 \
  94834554562528 f-94834554562528 t 94834555596640 94834555347456 \
  94834555596640 t 94834555517248 94834555517248 94834555517248 t \
  94834555385280 94834555385280 94834555385280 t 94834555516528 \
  94834555556800 94834555556800 1069 585 234 1056 900 234 A BD 1600 900
```
**Below is a cipher for the output**
``` text
field: 0   - AWW -  current workspace
field: 1   - VIS -  visible containers
field: 2   - HID -  hidden containers
field: 3   - EXS -  existing containers (VIS+HID)
field: 4   - AWP -  Active window position (b|e|m|o|g|i)
field: 5   - AWL -  Active window layout (t|v|h|s|u)
field: 6   - AWS -  Active window status (f|a|n)
field: 7   - AWC -  Active window container (A|B|C|D|X)
field: 8   - AWW -  Active window workspace
field: 9   - AWI -  Active container id (con_id)
field: 10  - AWM -  Active window mark
field: 11  - TWP -  Target window position (b|e|m|o|g|i)
field: 12  - TWL -  Target window layout (t|v|h|s|u)
field: 13  - TWS -  Target window status (f|a|n)
field: 14  - TWC -  Target window container (A|B|C|D|X)
field: 15  - TWW -  Target window workspace
field: 16  - TWI -  Target container id (con_id)
field: 17  - TWM -  Target window mark
field: 18  - LOA -  Container A layout
field: 19  - FCA -  Container A first child (con_id)
field: 20  - LCA -  Container A last child (con_id)
field: 21  - ACA -  Container A focused child (con_id)
field: 22  - LOB -  Container B layout
field: 23  - FCB -  Container B first child (con_id)
field: 24  - LCB -  Container B last child (con_id)
field: 25  - ACB -  Container B focused child (con_id)
field: 26  - LOC -  Container C layout
field: 27  - FCC -  Container C first child (con_id)
field: 28  - LCC -  Container C last child (con_id)
field: 29  - ACC -  Container C focused child (con_id)
field: 30  - LOD -  Container D layout
field: 31  - FCD -  Container D first child (con_id)
field: 32  - LCD -  Container D last child (con_id)
field: 33  - ACD -  Container D focused child (con_id)
field: 34  - SAB -  Stored AB split (mark i34SAB_*)
field: 35  - SAC -  Stored AC split (mark i34SAC_*)
field: 36  - SBD -  Stored BD split (mark i34SBD_*)
field: 37  - CAB -  Current AB split (width of i34XAC)
field: 38  - CAC -  Current AC split (height of i34A)
field: 39  - CBD -  Current BD split (height of i34B)
field: 40  - FAC -  Family AC memory (mark i34FAC_*)
field: 41  - FBD -  Family AC memory (mark i34FBD_*)
field: 42  - SDW -  Width of current workspace
field: 43  - SDH -  Height of curent workspace
field: 44  - WSF -  Workspace number whith i3fyra layout
field: 45  - AWX -  Active window X pos
field: 46  - AWY -  Active window Y pos
field: 47  - AWD -  Active window Width
field: 48  - AWH -  Active window Height
field: 49  - TWX -  Target window X pos
field: 50  - TWY -  Target window Y pos
field: 51  - TWD -  Target window Width
field: 52  - TWH -  Target window Height
field: 53  - AID -  Active window window ID
field: 54  - TID -  Target window window ID
field: 55  - AWB -  Active window titlebar height
field: 56  - TWB -  Target window titlebar height

position (b|e|m|g|i)
b - beginning  first child in container
e - end        last child in container
m - middle     neither first or last
o - only       only child in container
g - floating   not handled by i3fyra
i - tiled      not handled by i3fyra

layout (t|v|h|s|u)
t - tabbed
v - vertical
h - horizontal
s - stacked
u - unknown (not handled by i3fyra)

status (f|a|n)
f - focused (visible window in a tabbed container)
a - active window
n - neither active or focused
```
The best way to handle the output is to put it in an array.

Example:
``` text
$ list_array=($(i3list))
$ echo ${list_array[42]}
  1600 # width of current workspace
```

DEPENDENCIES
------------

i3wm
