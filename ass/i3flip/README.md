# i3flip - Tabswitching done right 

### usage

```text
i3flip DIRECTION
i3flip --move|-m DIRECTION
i3flip --help|-h
i3flip --version|-v
```

`i3flip` switch containers without leaving the parent.
Perfect for tabbed or stacked layout, but works on all
layouts. If direction is `next` and the active container is
the last, the first container will be activated.  

**DIRECTION** can be either *prev* or *next*, which can be
defined with different words:  

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
`~/.config/i3/config`:  
``` text
...
bindsym Mod4+Tab         exec --no-startup-id i3flip next
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev
```




