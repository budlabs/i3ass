`i3list` prints a list in a *array* formatted list. 
If a search criteria is given 
(`-c`|`-i`|`-n`|`-d`|`-m`) 
information about the first window matching the criteria is displayed. 
Information about the active window is always displayed. 
If no search criteria is given, 
the active window will also be the target window.

By using eval, 
the output can be used as an array in bash scripts, 
but the array needs to be declared first.

## EXAMPLE

```text
$ i3list
i3list[AWF]=0                  # Active Window floating
i3list[ATW]=270                # Active Window tab width
i3list[ATX]=540                # Active Window tab x postion
i3list[AWH]=1700               # Active Window height
i3list[AWI]=4194403            # Active Window id
i3list[AWW]=1080               # Active Window width
i3list[AFO]=AB                 # Active Window relatives
i3list[AWX]=0                  # Active Window x position
i3list[AFC]=B                  # Active Window cousin
i3list[AWY]=220                # Active Window y position
i3list[AFF]=CD                 # Active Window family
i3list[AFS]=D                  # Active Window sibling
i3list[AWB]=20                 # Active Window titlebar height
i3list[AFT]=A                  # Active Window twin
i3list[AWP]=C                  # Active Window parent
i3list[AWC]=94283162546096     # Active Window con_id
i3list[TWB]=20                 # Target Window titlebar height
i3list[TFS]=D                  # Target Window sibling
i3list[TFF]=CD                 # Target Window family
i3list[TWP]=C                  # Target Window Parent container
i3list[TFT]=A                  # Target Window twin
i3list[TWC]=94283162546096     # Target Window con_id
i3list[TWF]=0                  # Target Window Floating
i3list[TTW]=270                # Target Window tab width
i3list[TWH]=1700               # Target Window height
i3list[TTX]=540                # Target Window tab x postion
i3list[TWI]=4194403            # Target Window id
i3list[TWW]=1080               # Target Window width
i3list[TWX]=0                  # Target Window x position
i3list[TFO]=AB                 # Target Window relatives
i3list[TWY]=220                # Target Window y position
i3list[TFC]=B                  # Target Window cousin
i3list[CAF]=94283159300528     # Container A Focused container id
i3list[CBF]=94283160891520     # Container B Focused container id
i3list[CCF]=94283162546096     # Container C Focused container id
i3list[CAW]=1                  # Container A Workspace
i3list[CBW]=1                  # Container B Workspace
i3list[CCW]=1                  # Container C Workspace
i3list[CAL]=tabbed             # Container A Layout
i3list[CBL]=tabbed             # Container B Layout
i3list[CCL]=tabbed             # Container C Layout
i3list[SAB]=730                # Current split: AB
i3list[MCD]=770                # Stored split: CD
i3list[SAC]=220                # Current split: AC
i3list[SBD]=220                # Current split: BD
i3list[SCD]=1080               # Current split: CD
i3list[MAB]=730                # Stored split: AB
i3list[MAC]=220                # Stored split: AC
i3list[LEX]=CBA                # Existing containers (LVI+LHI)
i3list[LHI]=                   # Hidden i3fyra containers
i3list[LVI]=CBA                # Visible i3fyra containers
i3list[FCD]=C                  # Family CD memory
i3list[LAL]=ABCD               # All containers in family order
i3list[WAH]=1920               # Active Workspace height
i3list[WAI]=94283159180304     # Active Workspace con_id
i3list[WAW]=1080               # Active Workspace width
i3list[WSF]=1                  # i3fyra Workspace Number
i3list[WAX]=0                  # Active Workspace x position
i3list[WST]=1                  # Target Workspace Number
i3list[WAY]=0                  # Active Workspace y position
i3list[WFH]=1920               # i3fyra Workspace Height
i3list[WTH]=1920               # Target Workspace Height
i3list[WFI]=94283159180304     # i3fyra Workspace con_id
i3list[WAN]='1'                # Active Workspace name
i3list[WTI]=94283159180304     # Target Workspace con_id
i3list[WFW]=1080               # i3fyra Workspace Width
i3list[WTW]=1080               # Target Workspace Width
i3list[WFX]=0                  # i3fyra Workspace X position
i3list[WTX]=0                  # Target Workspace X poistion
i3list[WFY]=0                  # i3fyra Workspace Y position
i3list[WTY]=0                  # Target Workspace Y position
i3list[WFN]='1'                # i3fyra Workspace name
i3list[WSA]=1                  # Active Workspace number
i3list[WTN]='1'                # Target Workspace name


$ declare -A i3list # declares associative array
$ eval "$(i3list)"
$ echo ${i3list[WAW]}
1080
```
