
mtm = Move To Mark
----------------------

When launched without flags, `i3mtm` checks
floating status of current window. If it is tiled, the window becomes floating. if it is floating, a search for marks is done if no marks are found, window becomes tiled. otherwise a dmenu asks for a mark to move window to. if no selection is made, window is tiled but not moved. otherwise window is tiled and moved to selected mark.

with `-m` flag window is treaded as if it was floating even if it is tiled. (menu is forced)

examples
--------
you could replace your `floating toggle` binding with this: 

    bindsym Mod3+f exec --no-startup-id exec i3mtm      
    bindsym Mod3+Shift+f exec --no-startup-id exec i3mtm -m     

dependencies
------------
[i3get](https://github.com/budRich//tree/masteri3ass/i3get) | to identify and the terminal the floating state of current window
:---|:---
[dmenu](https://github.com/budRich//tree/masterblog/dmenu)   | tool that displays a menu

links
-----
[/r/i3wm](https://www.reddit.com/r/i3wm/comments/6xor8l/oci3mtm/)  
[/r/unixporn](https://redd.it/6xp6ul)

