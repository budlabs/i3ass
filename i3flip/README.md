I extracted and improved the tabswitching function from [i3fyra](https://budrich.github.io/i3ass/i3fyra) and it now works independently, with or without **i3fyra**.

* * *

`i3flip` - Tabswitching done right

SYNOPSIS
--------

`i3flip` [`-v`|`-h`] [n|next|p|prev]

DESCRIPTION
-----------

`i3flip` switch containers without leaving the parent.
Perfect for tabbed or stacked layout, but works on all
layouts. If direction is `next` (or `n`) and the active
container is the last, the first container will be activated.

OPTIONS
-------

`-v`
  Show version and exit.

`-h`
  Show help and exit.


EXAMPLE
-------

Put these keybinding definitions in the i3 config.  

`~/.config/i3/config`:  
``` text
bindsym Mod4+Tab         exec --no-startup-id i3flip n
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip p
```

Mod4/Super/Windows+Tab will switch to the next tab.
