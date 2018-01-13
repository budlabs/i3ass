

`i3pocus` - Intelligent window focusing

SYNOPSIS
--------

`i3pocus` [`-v`|`-h`] [`DIRECTION`]

DESCRIPTION
-----------

`i3pocus` is meant as a replacement for the default
focusing function (`i3-msg focus`) in **i3wm**. 
`i3pocus` moves the focus differently depending on
the layout the current window is places in AND the
the layout of the *receiving* container AND the 
DIRECTION the focus is moved.   

If the focus is moved horizontally (left|right) into
a horizontally split (splith) container, either the 
first (DIRECTION = right) or the last (DIRECTION = left)
window will be focused. This differ from the default
built in focus function, which always focus the window
that was last focused inside the container.  

A similar logic is applied to vertical focus/splits.  

If the receiving container layout is tabbed or stacked,
the focused (visible) container will get focus.  

If the current window is in a tabbed or stacked layout,
the parent container will be focused before moving the
focus in DIRECTION.  

OPTIONS
-------

`-v`  
  Show version and exit.

`-h`  
  Show help and exit.

`DIRECTION`  
  Direction to move the focus, can be either:   
  left, right, up, down OR l,r,u,d


EXAMPLES
--------

You can replace the default focus keybindings in
`~/.config/i3/config` with i3pocus in this fashion:  

``` text
# Default keybinding:
bindsym $mod+Left focus left

# With i3pocus:
# this assumes `i3pocus` is an executable file in your $PATH
bindsym $mod+Left i3pocus left
```

DEPENDENCIES
------------

i3
