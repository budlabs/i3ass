EXAMPLE
-------

replace the normal i3 focus keybindings with viswiz like this:  
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
