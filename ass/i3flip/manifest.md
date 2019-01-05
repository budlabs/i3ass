---
description: >
  Tabswitching done right
updated:       2019-01-05
version:       0.042
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2018-01-03
dependencies:  [i3, gawk]
see-also:      [i3(1)]
synopsis: |
    --help|-h
    --version|-v
    --move|-m **DIRECTION**
    **DIRECTION**
...

# long_description

`i3flip` switch containers without leaving the parent. Perfect for tabbed or stacked layout, but works on all layouts. If direction is `next` (or `n`) and the active container is the last, the first container will be activated.  

**DIRECTION** can be either *prev* or *next*, which can be defined with different words:  

**next**|right|down|n|r|d  
**prev**|left|up|p|l|u  

# examples

Put these keybinding definitions in the i3 config.  

`~/.config/i3/config`:  
``` text
bindsym Mod4+Tab         exec --no-startup-id i3flip next
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev
```

Mod4/Super/Windows+Tab will switch to the next tab.

