`i3viswiz` either prints a list of the currently
visible tiled windows to `stdout` or shifts the
focus depending on the arguments.  

If a *DIRECTION* (left|right|up|down) is passed,
`i3wizvis` will shift the focus to the window
closest in the given *DIRECTION*, or warp focus
if there are no windows in the given direction. 

# examples

replace the normal i3 focus keybindings with viswiz like this:

``` text
Normal binding:
bindsym Mod4+Shift+Left   focus left

Wizzy binding:
bindsym Mod4+Left   exec --no-startup-id i3viswiz left
```

example output:  
```text
$ i3viswiz --instance LIST

* 94475856575600 ws: 1 x: 0     y: 0     w: 1558  h: 410   | termsmall
- 94475856763248 ws: 1 x: 1558  y: 0     w: 362   h: 272   | gl
- 94475856286352 ws: 1 x: 0     y: 410   w: 1558  h: 643   | sublime_main
- 94475856449344 ws: 1 x: 1558  y: 272   w: 362   h: 781   | thunar-lna
```

If `--class` , `--instance`, `--title`,
`--titleformat`, `--winid` or `--parent` is used
together with the argument **LIST**.
i3viswiz will print this output, with the type in
the last column of the table (class in the
example above).  

If the argument is not LIST the container ID of
a visible window matching the criteria will be printed.  

Assuming the same scenario as the example above,
the following command:  
`$ i3viswiz --instance termsmall`  
will output the container_id (`94475856575600`).  
If no window is matching output will be blank.  

Multiple criteria is allowed:  
`$ i3viswiz --instance termsmall --class URxvt`   

**focus wrapping**  

if the setting "focus_wrapping" is set
to "workspace" in the i3config. i3viswiz will
wrap the focus only inside the currenttly
focused workspace instead of the whole work
area (other monitors).

The setting has to be present in the active config
before the first i3viswiz invokation.

To force this behavior otherwise, issue the following
command:  
`i3var set focus_wrap workspace`

Or to disable it:  
`i3var set focus_wrap normal`
