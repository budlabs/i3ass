`i3Kornhe` - move and resize windows gracefully

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
title means that we don't need to specify the mode
(move|size|m|s)  

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
`bash`
`gawk`
`i3`
`i3list`
`i3var`



