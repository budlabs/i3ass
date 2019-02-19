---
description: >
  Professional window focus for i3wm
updated:       2019-02-19
version:       0.044
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2018-01-18
dependencies:  [bash, gawk, i3]
see-also:      [bash(1), awk(1), i3(1)]
synopsis: |
    [--gap|-g GAPSIZE] **DIRECTION**
    [--focus|-f] --title|-t       [TARGET]
    [--focus|-f] --instance|-i    [TARGET]
    [--focus|-f] --class|-c       [TARGET]
    [--focus|-f] --titleformat|-o [TARGET]
    [--focus|-f] --winid|-d       [TARGET]
    [--focus|-f] --parent|-p      [TARGET]
    --help|-h
    --version|-v
...

# long_description

`i3viswiz` either prints a list of the currently visible tiled windows to `stdout` or shifts the focus depending on the arguments.  

If a *DIRECTION* (left|right|up|down) is passed, `i3wizvis` will shift the focus to the window closest in the given *DIRECTION*, or warp focus if there are no windows in the given direction.  

# examples

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


