`i3ass` - i3 assistance scripts


arbe
# `i3flip` - Tabswitching done right

SYNOPSIS
--------

```text
i3flip DIRECTION
i3flip --move|-m DIRECTION
i3flip --help|-h
i3flip --version|-v
```


DESCRIPTION
-----------

`i3flip` switch containers without leaving the
parent. Perfect for tabbed or stacked layout, but
works on all layouts. If direction is `next` (or
`n`) and the active container is the last, the
first container will be activated.  

**DIRECTION** can be either *prev* or *next*,
which can be defined with different words:  

**next**|right|down|n|r|d  
**prev**|left|up|p|l|u  


OPTIONS
-------


`--move`|`-m` DIRECTION  
Move the current tab instead of changing focus.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

Put these keybinding definitions in the i3
config.  

`~/.config/i3/config`:  
``` text
bindsym Mod4+Tab         exec --no-startup-id i3flip next
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev
```



Mod4/Super/Windows+Tab will switch to the next
tab.

DEPENDENCIES
------------

`i3` `gawk`

# `i3fyra` - An advanced, simple grid-based tiling layout


SYNOPSIS
--------

```text
i3fyra --show|-s CONTAINER
i3fyra --float|-a [--target|-t CRITERION]
i3fyra --hide|-z CONTAINER(s)
i3fyra --layout|-l LAYOUT
i3fyra --move|-m DIRECTION|CONTAINER [--speed|-p INT]  [--target|-t CRITERION]
i3fyra --help|-h
i3fyra --version|-v
```


DESCRIPTION
-----------

The layout consists of four containers:  

``` text
  A B
  C D
```



A container can contain one or more windows. The
internal layout of the containers doesn't matter.
By default the layout of each container is tabbed.  

A is always to the left of B and D. And always
above C. B is always to the right of A and C. And
always above D.  

This means that the containers will change names
if their position changes.  

The size of the containers are defined by the
three splits: AB, AC and BD.  

Container A and C belong to one family.  
Container B and D belong to one family.  

The visibility of containers and families can be
toggled. Not visible containers are placed on the
scratchpad.  

The visibility is toggled by either using *show*
(`-s`) or *hide* (`-z`). But more often by moving
a container in an *impossible* direction, (*see
examples below*).  

The **i3fyra** layout is only active on one
workspace. That workspace can be set with the
environment variable: `i3FYRA_WS`, otherwise the
workspace active when the layout is created will
be used.  

The benefit of using this layout is that the
placement of windows is more predictable and
easier to control. Especially when using tabbed
containers, which are very clunky to use with
*default i3*.


OPTIONS
-------


`--show`|`-s` CONTAINER  
Show target container. If it doesn't exist, it
will be created and current window will be put in
it. If it is visible, nothing happens.

`--float`|`-a`  
Autolayout. If current window is tiled: floating
enabled If window is floating, it will be put in a
visible container. If there is no visible
containers. The window will be placed in a hidden
container. If no containers exist, container
'A'will be created and the window will be put
there.

`--target`|`-t` CRITERION  
Criteria is a string passed to i3list to use a
different target then active window.  

Example:  
`$ i3fyra --move B --target "-i sublime_text"`
this will target the first found window with the
instance name *sublime_text*. See i3list(1), for
all available options.

`--hide`|`-z`  
Hide target containers if visible.  

`--layout`|`-l` LAYOUT  
alter splits Changes the given splits. INT is a
distance in pixels. AB is on X axis from the left
side if INT is positive, from the right side if it
is negative. AC and BD is on Y axis from the top
if INT is positive, from the bottom if it is
negative. The whole argument needs to be quoted.
Example:  
`$ i3fyra --layout 'AB=-300 BD=420'`  


`--move`|`-m` CONTAINER  
Moves current window to target container, either
defined by it's name or it's position relative to
the current container with a direction:
[`l`|`left`][`r`|`right`][`u`|`up`][`d`|`down`] If
the container doesnt exist it is created. If
argument is a direction and there is no container
in that direction, Connected container(s)
visibility is toggled. If current window is
floating or not inside ABCD, normal movement is
performed. Distance for moving floating windows
with this action can be defined with the `--speed`
option. Example: `$ i3fyra --speed 30 -m r` Will
move current window 30 pixels to the right, if it
is floating.

`--speed`|`-p` INT  
Distance in pixels to move a floating window.
Defaults to 30.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit


EXAMPLES
--------

If containers **A**,**B** and **C** are visible
but **D** is hidden or none existent, the visible
layout would looks like this:  

``` text
  A B
  C B
```



If action: *move up* (`-m u`) would be called
when container **B** is active and **D** is
hidden. Container **D** would be shown. If action
would have been: *move down* (`-m d`), **D** would
be shown but **B** would be placed below **D**,
this means that the containers will also swap
names. If action would have been *move left* (`-m
l`) the active window in B would be moved to
container **A**. If action was *move right* (`-m
r`) **A** and **C** would be hidden:  

``` text
  B B
  B B
```



If we now *move left* (`-m l`), **A** and **C**
would be shown again but to the right of **B**,
the containers would also change names, so **B**
becomes **A**, **A** becomes **B** and **C**
becomes **D**:  

``` text
  A B
  A D
```



If this doesn't make sense, check out this
demonstration on youtube:
https://youtu.be/kU8gb6WLFk8

ENVIRONMENT
-----------


`I3FYRA_MAIN_CONTAINER`  
This container will be the chosen when a
container is requested but not given. When using
the command autolayout (`-a`) for example, if the
window is floating it will be sent to the main
container, if no other containers exist. Defaults
to A. defaults to: A

`I3FYRA_WS`  
Workspace to use for i3fyra. If not set, the firs
workspace that request to create the layout will
be used. defaults to: 1

`I3FYRA_ORIENTATION`  
If set to `vertical` main split will be `AC` and
families will be `AB` and `CD`. Otherwise main
split will be `AB` and families will be `AC` and
`BD`. defaults to: horizontal

DEPENDENCIES
------------

`bash` `gawk` `i3` `i3list` `i3gw` `i3var`
`i3viswiz`

# `i3get` - Boilerplate and template maker for bash scripts


SYNOPSIS
--------

```text
i3get [--class|-c CLASS] [--instance|-i INSTANCE] [--title|-t TITLE] [--conid|-n CON_ID] [--winid|-d WIN_ID] [--mark|-m MARK] [--titleformat|-o TITLE_FORMAT] [--active|-a] [--synk|-y] [--print|-r OUTPUT]      
i3get --help|-h
i3get --version|-v
```


DESCRIPTION
-----------

Search for `CRITERIA` in the output of `i3-msg -t
get_tree`,  
return desired information.  If no arguments are
passed.  
`con_id` of acitve window is returned.  If there
is more then one criterion,  all of them must be
true to get results.


OPTIONS
-------


`--class`|`-c` CLASS  
Search for windows with the given class

`--instance`|`-i` INSTANCE  
Search for windows with the given instance

`--title`|`-t` TITLE  
Search for windows with title.

`--conid`|`-n` CON_ID  
Search for windows with the given con_id

`--winid`|`-d` WIN_ID  
Search for windows with the given window id

`--mark`|`-m` MARK  
Search for windows with the given mark

`--titleformat`|`-o` TITLE_FORMAT  
Search for windows with the given titleformat

`--active`|`-a`  
Currently active window (default)

`--synk`|`-y`  
Synch on. If this option is included,  
script will wait till target window exist.

`--print`|`-r` OUTPUT  
*OUTPUT* can be one or more of the following 
characters:  

|character | print
|:---------|:-----
|`t`       | title  
|`c`       | class  
|`i`       | instance  
|`d`       | Window ID  
|`n`       | Con_Id (default)  
|`m`       | mark  
|`w`       | workspace  
|`a`       | is active  
|`f`       | floating state  
|`o`       | title format  
|`v`       | visible state  


`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit


EXAMPLES
--------

search for window with instance name
sublime_text.  Request workspace, title and
floating state.  

``` shell
$ i3get --instance sublime_text -r wtf 
1
~/src/bash/i3ass/i3get (i3ass) - Sublime Text
user_off
```


DEPENDENCIES
------------

`bash` `gawk` `i3`

# `i3gw` - a ghost window wrapper for i3wm


SYNOPSIS
--------

```text
i3gw MARK
i3gw --help|-h
i3gw --version|-v
```


DESCRIPTION
-----------

`i3-msg` has an undocumented function: *open*, 
it creates empty containers,  or as I call them:
ghosts.  Since these empty containers doesn't
contain any windows  there is no
instance/class/title to identify them,  making it
difficult to manage them.  They do however have a
`con_id`  and I found that the easiest way to keep
track of ghosts, is to mark them.  That is what
this script does,  it creates a ghost,  get its
`con_id` and marks it.


OPTIONS
-------


`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

`$ i3gw casper`  

this will create a ghost marked casper,  you can
perform any action you can perform on a regular
container.

``` text
$ i3-msg [con_mark=casper] move to workspace 2
$ i3-msg [con_mark=casper] split v
$ i3-msg [con_mark=casper] layout tabbed
$ i3-msg [con_mark=casper] kill
```



the last command (`kill`), destroys the
container.

DEPENDENCIES
------------

`i3`

# `i3Kornhe` - move and resize windows gracefully


SYNOPSIS
--------

```text
i3Kornhe DIRECTION
i3Kornhe move [--speed|-p SPEED] [DIRECTION]
i3Kornhe size [--speed|-p SPEED] [DIRECTION]
i3Kornhe 1-9
i3Kornhe x
i3Kornhe --help|-h
i3Kornhe --version|-v
```


DESCRIPTION
-----------

i3Kornhe provides an alternative way to move and
resize windows in **i3**. It has some more
functions then the defaults and is more
streamlined. Resizing floating windows is done by
first selecting a corner of the window,  and then
moving that corner. See the wiki or the manpage
for details and how to add the required mode in
the i3 config file that is needed to use
**i3Kornhe**.


OPTIONS
-------


`--speed`|`-p` SPEED  
Sets speed or distance in pixels to use when
moving and resizing the windows.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.

# usage


To use this script a
[bindingmode](https://i3wm.org/docs/userguide.html#binding_modes)
named `sizemode` needs to be set in your i3 config
file. Below is how I have set up this mode:

`~/.config/i3/config`  

``` text

...

# these keybindings are outside the mode definition

# group A, enter size mode with direction:
bindsym Mod4+Control+Left    exec --no-startup-id i3Kornhe size left
bindsym Mod4+Control+Down    exec --no-startup-id i3Kornhe size down
bindsym Mod4+Control+Up      exec --no-startup-id i3Kornhe size up
bindsym Mod4+Control+Right   exec --no-startup-id i3Kornhe size right

# group B, enter move mode with direction:
# by using speed 0 (-p 0), this will only enter the mode without
# moving the window.
bindsym Mod4+Left      exec --no-startup-id i3Kornhe move -p 0 left
bindsym Mod4+Down      exec --no-startup-id i3Kornhe move -p 0 down
bindsym Mod4+Up        exec --no-startup-id i3Kornhe move -p 0 up
bindsym Mod4+Right     exec --no-startup-id i3Kornhe move -p 0 right

...

mode "sizemode" {
  # group 1 only send direction speed 30:
  bindsym Left          exec --no-startup-id i3Kornhe -p 30 left
  bindsym Down          exec --no-startup-id i3Kornhe -p 30 down
  bindsym Up            exec --no-startup-id i3Kornhe -p 30 up
  bindsym Right         exec --no-startup-id i3Kornhe -p 30 right
  
  # group 2 only send direction speed 5:
  bindsym Shift+Left    exec --no-startup-id i3Kornhe -p 5 left
  bindsym Shift+Down    exec --no-startup-id i3Kornhe -p 5 down
  bindsym Shift+Up      exec --no-startup-id i3Kornhe -p 5 up
  bindsym Shift+Right   exec --no-startup-id i3Kornhe -p 5 right

  # group 3 change size direction:
  bindsym Mod4+Left     exec --no-startup-id i3Kornhe size left
  bindsym Mod4+Down     exec --no-startup-id i3Kornhe size down
  bindsym Mod4+Up       exec --no-startup-id i3Kornhe size up
  bindsym Mod4+Right    exec --no-startup-id i3Kornhe size right

  # group 4 enter move mode:
  bindsym m exec --no-startup-id i3Kornhe move -p 0 left

  # group 5 move to absolute position 1-9:
  bindsym 1 exec --no-startup-id i3Kornhe 1
  bindsym 2 exec --no-startup-id i3Kornhe 2
  bindsym 3 exec --no-startup-id i3Kornhe 3
  bindsym 4 exec --no-startup-id i3Kornhe 4
  bindsym 5 exec --no-startup-id i3Kornhe 5
  bindsym 6 exec --no-startup-id i3Kornhe 6
  bindsym 7 exec --no-startup-id i3Kornhe 7
  bindsym 8 exec --no-startup-id i3Kornhe 8
  bindsym 9 exec --no-startup-id i3Kornhe 9

  # group 6 exit the mode
  bindsym Escape exec --no-startup-id i3Kornhe x
}
```



As you can see there are a lot of keybinding
definitions, but keep in mind, without `i3Kornhe`
you would need, one mode for every direction and
action (at least 8). And one reason i made this
script was unclutter and shrink my own config
file.  

A tip is also to use variables in the i3config:  
``` text
set $super bindsym Mod4
set $i3Kornhe exec --no-startup-id i3Kornhe
```



``` text
before:  
bindsym Mod4+Right exec --no-startup-id i3Kornhe move -p 0 right

after:  
$super+Right $i3Kornhe m -p 0 r
```



*Notice that the first character of the
mode/direction is enough. This shorter way will be
used when the commands are referenced in the rest
of this documentation.*  

Let us go through the processes that will happen
when the different actions are executed.  

*group B:*  
`$super+Left $i3Kornhe m -p 0 l`  

This will make i3Kornhe to enter **move mode**.
(*it will actually activate the i3 mode sizemode,
move is a pseudo mode that only i3Korhne knows*)
First thing i3Kornhe does is to store the current
title_format of the window (by using `i3var set`).  

It will then set the `title_format` to: `MOVE
w:WIDTH h:HEIGHT x:X y:Y`  

Populated with the actual dimensions and position
of the window. The first word, "MOVE", in the
title means that we don'"'"'t need to specify the
mode (move|size|m|s)  

So if a keybinding from **group 1** or **group
2** is executed it will move the window in the
specified direction with the specified speed
(speed defaults to 10 if not set).  

If we would execute a keybinding from **group
3**, where the mode is specified (size), this
would change the title to:  

`SIZE:CORNER w:WIDTH h:HEIGHT x:X y:Y`  

CORNER is which corner of the window that will
get moved. The CORNER is set with a direction:  

| direction | corner
|:----------|:------
| Left      | topleft
| Down      | bottomleft
| Up        | topright
| Right     | bottomright



This might look strange at first, but if you look
at the keys HJKL, you will see that there is some
logic to it.

If we now execute a keybinding from ***group 1***
or ***group 2*** (without a mode definition), the
named corner will *get moved*. To change corner
execute a keybinding from **group 3**. To switch
back to MOVE mode, we only need a single
keybinding (**group 4**):  
`bindsym m $i3Kornhe m -p 0 l`


The direction and speed is needed but will not
have any visual effect. To exit back to default
mode execute `i3Kornhe` with `x` as the only
argument, (**group 6**), this will exit the mode
and reset the title_format to what it was
initially.  

You can also execute `i3Kornhe` with a number in
the range 1-9 as a single argument. This will move
the currently active window (if it is floating) to
the position corresponding to the number:  

``` text
123
456
789
```



One important note is that if the active window
is tiled, `i3Kornhe` will move it normally or
resize it according to this table:  

| direction | resize
|:----------|:-------------
| Left      | shrink width
| Down      | shrink height
| Up        | grow height
| Right     | grow width




DEPENDENCIES
------------

`bash` `gawk` `i3` `i3list` `i3var`

# `i3list` - list information about the current i3 session.


SYNOPSIS
--------

```text
i3list --instance|-i TARGET
i3list --class|-c    TARGET
i3list --conid|-n    TARGET
i3list --winid|-d    TARGET
i3list --mark|-m     TARGET
i3list --title|-t    TARGET
i3list --help|-h
i3list --version|-v
```


DESCRIPTION
-----------

`i3list` prints a list in a *array* formatted
list.  If a search criteria is given 
(`-c`|`-i`|`-n`|`-d`)  information about the first
window matching the criteria is displayed. 
Information about the active window is always
displayed.  If no search criteria is given,  the
active window will also be the target window.

By using eval,  the output can be used as an
array in bash scripts,  but the array needs to be
declared first.


OPTIONS
-------


`--instance`|`-i` TARGET  
Search for windows with a instance matching
*TARGET*

`--class`|`-c` TARGET  
Search for windows with a class matching *TARGET*

`--conid`|`-n` TARGET  
Search for windows with a **CON_ID** matching
*TARGET*

`--winid`|`-d` TARGET  
Search for windows with a **WINDOW_ID** matching
*TARGET*

`--mark`|`-m` TARGET  
Search for windows with a **mark** matching
*TARGET*

`--title`|`-t` TARGET  
Search for windows with a **title** matching
*TARGET*  

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

```text$ i3list
i3list[AWF]=0                  # Active Window floating
i3list[ATW]=270                # Active Window tab width
i3list[ATX]=540                # Active Window tab x postion
i3list[AWH]=1700               # Active Window height
i3list[AWI]=4194403            # Active Window id
i3list[AWW]=1080               # Active Window width
i3list[AFO]=AB                 # Active Window relatives
i3list[AWX]=0                  # Active Window x position
i3list[AFC]=B                  # Active Window cousin
i3list[AWY]=220                # Active Window y position
i3list[AFF]=CD                 # Active Window family
i3list[AFS]=D                  # Active Window sibling
i3list[AWB]=20                 # Active Window titlebar height
i3list[AFT]=A                  # Active Window twin
i3list[AWP]=C                  # Active Window parent
i3list[AWC]=94283162546096     # Active Window con_id
i3list[TWB]=20                 # Target Window titlebar height
i3list[TFS]=D                  # Target Window sibling
i3list[TFF]=CD                 # Target Window family
i3list[TWP]=C                  # Target Window Parent container
i3list[TFT]=A                  # Target Window twin
i3list[TWC]=94283162546096     # Target Window con_id
i3list[TWF]=0                  # Target Window Floating
i3list[TTW]=270                # Target Window tab width
i3list[TWH]=1700               # Target Window height
i3list[TTX]=540                # Target Window tab x postion
i3list[TWI]=4194403            # Target Window id
i3list[TWW]=1080               # Target Window width
i3list[TWX]=0                  # Target Window x position
i3list[TFO]=AB                 # Target Window relatives
i3list[TWY]=220                # Target Window y position
i3list[TFC]=B                  # Target Window cousin
i3list[CAF]=94283159300528     # Container A Focused container id
i3list[CBF]=94283160891520     # Container B Focused container id
i3list[CCF]=94283162546096     # Container C Focused container id
i3list[CAW]=1                  # Container A Workspace
i3list[CBW]=1                  # Container B Workspace
i3list[CCW]=1                  # Container C Workspace
i3list[CAL]=tabbed             # Container A Layout
i3list[CBL]=tabbed             # Container B Layout
i3list[CCL]=tabbed             # Container C Layout
i3list[SAB]=730                # Current split: AB
i3list[MCD]=770                # Stored split: CD
i3list[SAC]=220                # Current split: AC
i3list[SBD]=220                # Current split: BD
i3list[SCD]=1080               # Current split: CD
i3list[MAB]=730                # Stored split: AB
i3list[MAC]=220                # Stored split: AC
i3list[LEX]=CBA                # Existing containers (LVI+LHI)
i3list[LHI]=                   # Hidden i3fyra containers
i3list[LVI]=CBA                # Visible i3fyra containers
i3list[FCD]=C                  # Family CD memory
i3list[LAL]=ABCD               # All containers in family order
i3list[WAH]=1920               # Active Workspace height
i3list[WAI]=94283159180304     # Active Workspace con_id
i3list[WAW]=1080               # Active Workspace width
i3list[WSF]=1                  # i3fyra Workspace Number
i3list[WAX]=0                  # Active Workspace x position
i3list[WST]=1                  # Target Workspace Number
i3list[WAY]=0                  # Active Workspace y position
i3list[WFH]=1920               # i3fyra Workspace Height
i3list[WTH]=1920               # Target Workspace Height
i3list[WFI]=94283159180304     # i3fyra Workspace con_id
i3list[WAN]='1'                # Active Workspace name
i3list[WTI]=94283159180304     # Target Workspace con_id
i3list[WFW]=1080               # i3fyra Workspace Width
i3list[WTW]=1080               # Target Workspace Width
i3list[WFX]=0                  # i3fyra Workspace X position
i3list[WTX]=0                  # Target Workspace X poistion
i3list[WFY]=0                  # i3fyra Workspace Y position
i3list[WTY]=0                  # Target Workspace Y position
i3list[WFN]='1'                # i3fyra Workspace name
i3list[WSA]=1                  # Active Workspace number
i3list[WTN]='1'                # Target Workspace name


$ declare -A i3list # declares associative array
$ eval "$(i3list)"
$ echo ${i3list[WAW]}
1080
```


DEPENDENCIES
------------

`bash` `gawk` `i3`

# `i3run` - Run, Raise or hide windows in i3wm


SYNOPSIS
--------

```text
i3run --instance|-i INSTANCE [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --class|-c CLASS [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --title|-t  TITLE [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --conid|-n CON_ID [--summon|-s] [--nohide|-g] [--mouse|-m] [--command|-e COMMAND] [--rename|-x OLD_NAME]
i3run --help|-h
i3run --version|-v
```


DESCRIPTION
-----------

`i3run` let's you use one command for multiple
functions related to the same window identified by
a given criteria.  `i3run` will take different
action depending on the state of the searched
window:  

| **target window state**          | **action**
|:---------------------------------|:------------
| Active and not handled by i3fyra | hide
| Active and handled by i3fyra     | hide container, if not `-g` is set
| Handled by i3fyra and hidden     | show container, activate
| Not handled by i3fyra and hidden | show window, activate
| Not on current workspace         | goto workspace or show if `-s` is set
| Not found                        | execute command (`-e`)




Hidden in this context,  means that window is on
the scratchpad. Show in this context means,  move
window to current workspace.  


`-e` is optional, if no *COMMAND* is passed and
no window is found,  nothing happens.  It is
important that `-e` *COMMAND* is **the last of the
options**.  It is also important that *COMMAND*
**will spawn a window matching the criteria**, 
otherwise the script will get stuck in a loop
waiting for the window to appear. (*it will stop
waiting for the window to appear after 10
seconds*)


OPTIONS
-------


`--instance`|`-i` INSTANCE  
Search for windows with the given INSTANCE

`--summon`|`-s`  
Instead of switching workspace, summon window to
current workspace

`--nohide`|`-g`  
Don't hide window/container if it's active.

`--mouse`|`-m`  
The window will be placed on the location of the
mouse cursor when it is created or shown. (*needs
`xdotool`*)  

`--command`|`-e` COMMAND  
Command to run if no window is found. Complex
commands can be written inside quotes:  
```
i3run -i sublime_text -e 'subl && notify-send "sublime is started"'
```



`--rename`|`-x` OLD_NAME  
If the search criteria is `-i` (instance), the
window with instance: *OLDNAME* will get a n new
instance name matching the criteria when it is
created (*needs `xdotool`*).

`--class`|`-c` CLASS  
Search for windows with the given CLASS

`--title`|`-t` TITLE  
Search for windows with the given TITLE

`--conid`|`-n` CON_ID  
Search for windows with the given CON_ID

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


DEPENDENCIES
------------

`bash` `gawk` `i3list` `i3get` `i3var` `xdotool`
`i3fyra` `i3`

# `i3var` - Set or get a i3 variable


SYNOPSIS
--------

```text
i3var set VARNAME [VALUE]
i3var get VARNAME
i3var --help|-h
i3var --version|-v
```


DESCRIPTION
-----------

`i3var` is used to get or set a "variable" that
is bound to the current i3wm session.  The
variable is actually the mark of a "ghost window"
on the scratch pad.

`set`  \[VALUE\]  
If *VARNAME* doesn't exist, a new window and mark
will be created.  If *VARNAME* exists it's value
will be replaced with *VALUE*.  
If *VALUE* is not defined,  *VARNAME* will get
unset.  

`get`  
if *VARNAME* exists,  its value will be returned
window.  


OPTIONS
-------


`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


DEPENDENCIES
------------

`bash` `gawk` `sed` `i3` `i3gw`

# `i3viswiz` - Professional window focus for i3wm


SYNOPSIS
--------

```text
i3viswiz [--gap|-g GAPSIZE] **DIRECTION**
i3viswiz [--focus|-f] --title|-t       [TARGET]
i3viswiz [--focus|-f] --instance|-i    [TARGET]
i3viswiz [--focus|-f] --class|-c       [TARGET]
i3viswiz [--focus|-f] --titleformat|-o [TARGET]
i3viswiz [--focus|-f] --winid|-d       [TARGET]
i3viswiz [--focus|-f] --parent|-p      [TARGET]
i3viswiz --help|-h
i3viswiz --version|-v
```


DESCRIPTION
-----------

`i3viswiz` either prints a list of the currently
visible tiled windows to `stdout` or shifts the
focus depending on the arguments.  

If a *DIRECTION* (left|right|up|down) is passed,
`i3wizvis` will shift the focus to the window
closest in the given *DIRECTION*, or warp focus if
there are no windows in the given direction.  


OPTIONS
-------


`--gap`|`-g` GAPSIZE  
Set GAPSIZE (defaults to 5). GAPSIZE is the
distance in pixels from the current window where
new focus will be searched.  

`--focus`|`-f`  
When used in conjunction with: `--titleformat`,
`--title`, `--class`, `--instance`, `--winid` or
`--parent`. The **CON_ID** of **TARGET** window
will get focused if it is visible.

`--title`|`-t` [TARGET]  
If **TARGET** matches the **TITLE** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**TITLE** as the last field of each row.

`--instance`|`-i` [TARGET]  
If **TARGET** matches the **INSTANCE** of a
visible window, that windows  **CON_ID** will get
printed to `stdout`. If no **TARGET** is
specified, a list of all tiled windows will get
printed with  **INSTANCE** as the last field of
each row.

`--class`|`-c` [TARGET]  
If **TARGET** matches the **CLASS** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**CLASS** as the last field of each row.

`--titleformat`|`-o` [TARGET]  
If **TARGET** matches the **TITLE_FORMAT** of a
visible window, that windows  **CON_ID** will get
printed to `stdout`. If no **TARGET** is
specified, a list of all tiled windows will get
printed with  **TITLE_FORMAT** as the last field
of each row.

`--winid`|`-d` [TARGET]  
If **TARGET** matches the **WIN_ID** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**WIN_ID** as the last field of each row.


`--parent`|`-p` [TARGET]  
If **TARGET** matches the **PARENT** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**PARENT** as the last field of each row.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

replace the normal i3 focus keybindings with
viswiz like this:  
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




DEPENDENCIES
------------

`bash` `gawk` `i3`


EXAMPLES
--------
Execute a script with the `--help` flag to
display help about the command.

`i3get --help` display [i3get] help  
`i3get --version` display [i3get] version  
`man i3get` show [i3get] man page  
`i3ass` show version info for all scripts and
dependencies.

DEPENDENCIES
------------
`bash`
`gawk`
`i3`
`git`



