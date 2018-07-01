# `i3list` - Prints information about the current i3 session to `stdout`.

SYNOPSIS
--------

`i3list` [`-v`|`-h`]  

`i3list`  
`i3list` [`-c` *CLASS*]  
`i3list` [`-i` *INSTANCE*]  
`i3list` [`-n` *CON_ID*]  
`i3list` [`-d` *WINDOW_ID*]  

DESCRIPTION
-----------

`i3list` prints a list in a *array* formatted list. 
If a search criteria is given (`-c`|`-i`|`-n`|`-d`) 
information about the first window matching the criteria
is displayed. Information about the active window is always
displayed. If no search criteria is given, the active window
will also be the target window.  

By using eval, the output can be used as an array in bash 
scripts, but the array needs to be declared first.

OPTIONS
-------

`-v`  
Show version and exit.  

`-h`  
Show help and exit.  

`-c` *CLASS*  
Search for windows with the given CLASS  

`-i` *INSTANCE*   
Search for windows with the given INSTANCE  

`-n` *CON_ID*  
Search for windows with the given CON_ID  

`-d` *WINDOW_ID*  
Search for windows with the given WINDOW_ID  

EXAMPLES
--------

``` shell
$ i3list
i3list[AWF]=0                # active window floating
i3list[AWH]=451              # Active window height
i3list[AWI]=2097161          # active window id
i3list[AWW]=1166             # Active window width
i3list[AFO]=BD               # active window relatives
i3list[AWX]=0                # Active window x position
i3list[AFC]=D                # active window cousin
i3list[AWY]=0                # Active window y position
i3list[AFF]=AC               # active window family
i3list[AFS]=C                # active window sibling
i3list[AWB]=20               # Active window titlebar height
i3list[AFT]=B                # active window twin
i3list[AWP]=A                # active window parent
i3list[AWC]=94851560291216   # active window con_id
i3list[TWB]=20               # Target window titlebar height
i3list[TFS]=C                # target window sibling
i3list[TFF]=AC               # target window family
i3list[TWP]=A                # target window parent
i3list[TFT]=B                # target window twin
i3list[TWC]=94851560291216   # target window con_id
i3list[TWF]=0                # target window floating
i3list[TWH]=451              # Target window height
i3list[TWI]=2097161          # target window id
i3list[TWW]=1166             # Target window width
i3list[TWX]=0                # Target window x position
i3list[TFO]=BD               # target window relatives
i3list[TWY]=0                # Target window y position
i3list[TFC]=D                # target window cousin
i3list[CAF]=94851560291216   # container A focused container id
i3list[CCF]=94851559487504   # container C focused container id
i3list[CDF]=94851560318768   # container D focused container id
i3list[CAW]=1                # container A workspace
i3list[CCW]=1                # container C workspace
i3list[CAL]="tabbed"         # container A layout
i3list[CDW]=1                # container D workspace
i3list[CCL]="tabbed"         # container C layout
i3list[CDL]="tabbed"         # container D layout
i3list[SAB]=1166             # current split: AB
i3list[SAC]=451              # current split: AC
i3list[MAB]=-370             # stored split: AB
i3list[MAC]=130              # stored split: AC
i3list[MBD]=250              # stored split: BD
i3list[LAL]=ACBD             # all containers in family order
i3list[LEX]=DCA              # existing containers (LVI+LHI)
i3list[LHI]=                 # hidden i3fyra containers
i3list[LVI]=DCA              # visible i3fyra containers
i3list[WAH]=900              # Active workspace height
i3list[WAW]=1600             # Active workspace width
i3list[WSF]=1                # workspace i3fyra number
i3list[WST]=1                # workspace number target
i3list[WSH]=900              # workspace i3fyra height
i3list[WSW]=1600             # workspace i3fyra width
i3list[WSA]=1                # workspace number active

$ declare -A i3list # declares associative array
$ eval "$(i3list)"
$ echo ${i3list[WAW]}
1600
```


DEPENDENCIES
------------

i3
