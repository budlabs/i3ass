# `i3var` - Set or get a i3 variable

SYNOPSIS
--------

`i3var` [`-v`|`-h`]  
`i3var` `set` *VARNAME* [*VALUE*]  
`i3var` `get` *VARNAME*  

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
