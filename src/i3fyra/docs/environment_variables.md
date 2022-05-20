
## ENVIRONMENT

### I3FYRA_WS

Workspace to use for i3fyra. If not set, the firs
workspace that request to create the layout will
be used.

### I3FYRA_MAIN_CONTAINER  

This container will be the chosen when a container
is requested but not given. When using the command
autolayout (`-a`) for example, if the window is
floating it will be sent to the main container, if
no other containers exist. Defaults to A.

### I3FYRA_ORIENTATION  

If set to `vertical` main split will be `AC` and
families will be `AB` and `CD`. Otherwise main
split will be `AB` and families will be `AC` and
`BD`.

### I3_KING_PID_FILE  

When i3king is running this file contains the pid
of the i3king process. It is used by **i3fyra** to
know if i3king is running, if it is, it will try
to match windows against the rules when `--float`
option toggles the floating state to tiled.
