

*I just made this script to keep my [i3config](/dots/config/i3/config) cleaner. It probably needs tweaking if someone other then budRich uses it* ;)

*******************************

Launch a command in a new urxvt window
======================================
Uses [i3run](https://github.com/budRich/i3ass/tree/master/i3run) to run or raise a window with the instancename: 
`COMMAND`. If no window is found, `COMMAND` is ran in a urxvt window 
with the same instance name as `COMMAND`. When the command exits 
window is cleared and returned to bash.

dependencies
------------
- urxvt
- [i3run](https://github.com/budRich/i3ass/tree/master/i3run)

**usage**  
`i3term COMMAND`

| **option** | **argument** | **function**                  
|:-------|:---------|:--------------------------
| -v     |          | show version info and exit
| -h     |          | show this help and exit   


**example**  
`bindsym Mod3+o exec --no-startup-id exec termrun htop`

