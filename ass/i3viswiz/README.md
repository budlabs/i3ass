# i3viswiz - Professional window focus for i3wm 

### usage

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

`i3viswiz` either prints a list of the currently visible
tiled windows to `stdout` or shifts the focus depending on
the arguments.  

If a *DIRECTION* (left|right|up|down) is passed, `i3wizvis`
will shift the focus to the window closest in the given
*DIRECTION*, or warp focus if there are no windows in the
given direction.  


OPTIONS
-------

`--gap`|`-g` GAPSIZE  
Set GAPSIZE (defaults to 5). GAPSIZE is the distance in
pixels from the current window where new focus will be
searched.  

`--focus`|`-f`  
When used in conjunction with: `--titleformat`, `--title`,
`--class`, `--instance`, `--winid` or `--parent`. The
**CON_ID** of **TARGET** window will get focused if it is
visible.

`--title`|`-t` [TARGET]  
If **TARGET** matches the **TITLE** of a visible window,
that windows  **CON_ID** will get printed to `stdout`. If no
**TARGET** is specified, a list of all tiled windows will
get printed with  **TITLE** as the last field of each row.

`--instance`|`-i` [TARGET]  
If **TARGET** matches the **INSTANCE** of a visible window,
that windows  **CON_ID** will get printed to `stdout`. If no
**TARGET** is specified, a list of all tiled windows will
get printed with  **INSTANCE** as the last field of each
row.

`--class`|`-c` [TARGET]  
If **TARGET** matches the **CLASS** of a visible window,
that windows  **CON_ID** will get printed to `stdout`. If no
**TARGET** is specified, a list of all tiled windows will
get printed with  **CLASS** as the last field of each row.

`--titleformat`|`-o` [TARGET]  
If **TARGET** matches the **TITLE_FORMAT** of a visible
window, that windows  **CON_ID** will get printed to
`stdout`. If no **TARGET** is specified, a list of all tiled
windows will get printed with  **TITLE_FORMAT** as the last
field of each row.

`--winid`|`-d` [TARGET]  
If **TARGET** matches the **WIN_ID** of a visible window,
that windows  **CON_ID** will get printed to `stdout`. If no
**TARGET** is specified, a list of all tiled windows will
get printed with  **WIN_ID** as the last field of each row.


`--parent`|`-p` [TARGET]  
If **TARGET** matches the **PARENT** of a visible window,
that windows  **CON_ID** will get printed to `stdout`. If no
**TARGET** is specified, a list of all tiled windows will
get printed with  **PARENT** as the last field of each row.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.

EXAMPLES
--------
replace the normal i3 focus keybindings with viswiz like
this:  
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





