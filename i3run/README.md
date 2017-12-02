
run, raise or minimize a program depending on its state.
-------------------------------------------

if target window doesn't exist, a given command is launched. if target window is on another workspace, it is moved to current workspace. If target window doesn't have focus it will be given focus. If target window has focus it will be sent to the scratchpad.

usage
-----
run i3run with **ONE** of the following options to define target window:  
`-c CLASS, -i INSTANCE, -t TITLE`  
the last option you should include is:  
`-e COMMAND`  
It is important that `-e COMMAND` is last of the options.

example
-------
    i3run -i sublime_text -e subl
    bindsym Mod4+s exec --no-startup-id exec i3run -i sublime_text -e subl

this example will look for a window with the instance `sublime_text` and focus it if it exist, *minimize* it if it already is focused and run the command: `subl` if it doesn't exist.

dependencies
------------
[i3get](https://github.com/budRich//tree/masteri3ass/i3get) | to identify and the terminal the floating state of current window
:---|:---

links
-----
[/r/i3wm](https://www.reddit.com/r/i3wm/comments/6x0p0q/oc_i3run/)
