# `i3flip` - Tabswitching done right

SYNOPSIS
--------

`i3flip` `-v`|`-h`    
`i3flip` n|r|d|next|right|down   
`i3flip` p|l|u|prev|left|up   

DESCRIPTION
-----------

`i3flip` switch containers without leaving the
parent. Perfect for tabbed or stacked layout, but
works on all layouts. If direction is `next` (or
`n`) and the active container is the last, the
first container will be activated.  

OPTIONS
-------

`-v`|`--version`  
Show version and exit.  

`-h`|`--help`  
Show help and exit.  


EXAMPLE
-------

Put these keybinding definitions in the i3 config.  

`~/.config/i3/config`:  
``` text
bindsym Mod4+Tab         exec --no-startup-id i3flip next
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev
```

Mod4/Super/Windows+Tab will switch to the next tab.

