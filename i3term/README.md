
Launch a command in a new urxvt window
======================================
Uses [i3run](https://github.com/budRich/i3ass/tree/master/i3run) to run or raise a window with the instancename: `COMMAND`. If no window is found, `COMMAND` is ran in a urxvt window with the same instance name as `COMMAND`. When the command exits window is cleared and returned to bash.

*I just made this script to keep my i3config cleaner, and to be able to set fixedsys as the font. Probably needs tweaking if someone other then budRich uses it* ;)

dependencies
------------
urxvt

usage
-----
`i3term COMMAND`

**example:**  
`bindsym Mod3+o exec --no-startup-id exec termrun htop`




