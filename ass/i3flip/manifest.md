---
description: >
  Tabswitching done right
updated:       2019-02-19
version:       0.05
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2018-01-03
dependencies:  [i3, gawk]
see-also:      [i3(1)]
synopsis: |
    DIRECTION
    --move|-m DIRECTION
    --help|-h
    --version|-v
...

# long_description

`i3flip` switch containers without leaving the parent. Perfect for tabbed or stacked layout, but works on all layouts. If direction is `next` and the active container is the last, the first container will be activated.  

**DIRECTION** can be either *prev* or *next*, which can be defined with different words:  

**next**|right|down|n|r|d  
**prev**|left|up|p|l|u  

# examples

`~/.config/i3/config`:  
``` text
...
bindsym Mod4+Tab         exec --no-startup-id i3flip next
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev
```

