`i3flip` switch containers without leaving the
parent. Perfect for tabbed or stacked layout, but
works on all layouts. If direction is `next` and
the active container is the last, the first
container will get focused.

**DIRECTION can be either *prev* or *next*, which
**can be defined with different words:

**next**|right|down|n|r|d  
**prev**|left|up|p|l|u  

### examples

`~/.config/i3/config`:  

    ...
    bindsym Mod4+Tab         exec --no-startup-id i3flip next
    bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev


