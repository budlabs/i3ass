

In the screenshot below, the windows to the right are tiled, and a ghostwindow is tiled on the left half of the screen. The other windows are floating.

[![](https://budrich.github.io/img/awd/ss-i3gw1.png)](https://budrich.github.io/img/org/ss-i3gw1.png)

*******************************
A Ghost window wrapper for i3wm.

i3-msg has an undocumented function (open) that creates
empty containers, or as I call them: ghosts.
Since these empty containers doesn't contain any windows
there is no instance/class/title to identify them, making
it difficult to control them. They do however have a con_id and
I found the easiest way to keep track of the ghosts is to
mark them. That is what this script does, it creates a ghost
get its con_id and mark it.

usage
-----
`$ i3gw [-h|-v] MARK`

| **option** | **argument** | **function**                   |
|:-------|:---------|:---------------------------|
| -v     |          | show version info and exit |
| -h     |          | show this help and exit    |

example:  
`i3gw casper`

this will create a ghost marked casper, you can perform any action
you can perform on a regular container.

example:
``` text
i3-msg [con_mark=casper] move to workspace 2
i3-msg [con_mark=casper] split v
i3-msg [con_mark=casper] layout tabbed
i3-msg [con_mark=casper] kill
```
the last example (kill), destroys the container.

