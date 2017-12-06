

*******************************
When launched without options, i3mtm checks
floating status of current window. If it is
tiled, the window becomes floating.
If it is floating, a search for marks is done,
if no marks are found, window becomes tiled.
Otherwise a dmenu asks for a mark to move window to.
If no selection is made, window is tiled but not moved.
Otherwise window is tiled and moved to selected mark.

With -m option window is treaded as if it was floating
even if it is tiled. (menu is forced)  

**usage**  
`$ i3mtm [OPTION]`

| **option** | **argument** | **function**                   |
|:-------|:---------|:---------------------------|
| -v     |          | show version info and exit |
| -h     |          | show this help and exit    |

**examples**  
you could replace your floating toggle binding with this:  
``` text
bindsym Mod3+f exec --no-startup-id exec i3mtm  
bindsym Mod3+Shift+f exec --no-startup-id exec i3mtm -m  
```

dependencies
------------
* i3get
* dmenu

