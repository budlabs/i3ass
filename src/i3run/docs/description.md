
i3run will try to find a window matching a criteria.
Criteria is specified with one or more command line options:  
`--class , --instance , --title , --conid , --winid`  
All criteria specified must match, if multiple windows
match all criteria one will be chosen at random.  

Depending on the state of target window different actions will apply:  

    Active and not handled by i3fyra     | send to scratchpad
    Active and handled by i3fyra         | send container to scratchpad
    Handled by i3fyra and hidden         | **show** container
    Not handled by i3fyra and hidden     | **show** window
    Not on current workspace             | goto workspace and focus window
    Not active, not hidden, on workspace | focus window
    Not found                            | execute COMMAND

Hidden in this context,  means that window is on
the scratchpad. Show in this context means,  move
window to current workspace.

With `--nohide` set windows/containers will not be
sent to the scratchpad by **i3run**.  

With `--summon` windows not on current workspace
will be sent to current workspace instead of switching
workspace.

COMMAND is everything after -- , or the argument to `--command`.  

If COMMAND doesn't result in a window that matches the criteria
**i3run** will *get stuck* waiting for such a window, and it can
lead to undesired behavior.  
Don't do this: `i3run --class Google-chrome -- firefox`
