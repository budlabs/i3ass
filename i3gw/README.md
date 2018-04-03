In the screenshot below, the windows to the right are tiled, and a ghostwindow is tiled on the left half of the screen. The other windows are floating.

[![](https://budrich.github.io/img/awd/ss-i3gw1.png)](https://budrich.github.io/img/org/ss-i3gw1.png)

This might seems like a novel and unusable feature, but it is actually crucial for many of my script ([i3fyra](https://budrich.github.io/i3ass/i3fyra), [i3var](https://budrich.github.io/i3ass/i3var)) to work.

* * *

`i3gw` - A Ghost window wrapper for i3wm.

SYNOPSIS
--------

`i3gw` [`-v`|`-h`] *MARK*

DESCRIPTION
-----------

`i3-msg` has an undocumented function: *open*, 
it creates empty containers, or as I call them: ghosts.
Since these empty containers doesn't contain any windows
there is no instance/class/title to identify them, making
it difficult to control them. They do however have a `con_id` and
I found the easiest way to keep track of the ghosts is to
mark them. That is what this script does, it creates a ghost,
get its `con_id` and marks it.


OPTIONS
-------

`-v`
  Show version and exit.

`-h`
  Show help and exit.


EXAMPLES
--------

`i3gw casper`  

this will create a ghost marked casper, you can perform any action
you can perform on a regular container.

``` text
i3-msg [con_mark=casper] move to workspace 2
i3-msg [con_mark=casper] split v
i3-msg [con_mark=casper] layout tabbed
i3-msg [con_mark=casper] kill
```

the last example (`kill`), destroys the container.

DEPENDENCIES
------------

i3wm
