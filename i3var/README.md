I found that marking windows is both clunky and it can have a negative impact on the workflow for users who use marks for other things. So i made i3var, it creates a ghostwindow on the scratchpad and use it to hold a variable. This can also be used for things that are not window related. I can for example keep track of my current wallpaper, but i have made some other crazy experiments with this and it works really well, much better then marks. Be aware that if you are using a listener script of some kind, it can get confused by the windows, but there are workarounds.

`i3var` - Set or get a i3 variable

SYNOPSIS
--------

`i3var` [`-v`|`-h`] [`set` *VARNAME* [*VALUE*]]|[`get` *VARNAME*] 

DESCRIPTION
-----------

`i3var` is used to get or set a "variable" that is 
bound to the current i3wm session. The variable is
actually the mark of a "ghost window" on the scratch 
pad. 

OPTIONS
-------

`-v`
  Show version and exit.

`-h`
  Show help and exit.

`set` 
  if there is no variable with *VARNAME* an new 
  window and mark will be created. If *VARNAME* 
  exists it's value will be change. If *VALUE*
  is not defined, *VARNAME* will get unset 
  (window will get killed).

`get` 
  if *VARNAME* exists, its value will be returned 
  window and mark will be created. If *VARNAME* 
  exists it's value will be changed.

DEPENDENCIES
------------

i3gw
