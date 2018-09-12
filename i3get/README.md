# `i3get` - Return information about i3wm.

SYNOPSIS
--------

`i3get` [`-h`|`-v`]  
`i3get` [`OPTION` [*CRITERIA*]] [`-r` [tcidnmwafov]] [`-y`]  

DESCRIPTION
-----------

Search for `CRITERIA` in the output of `i3-msg -t
get_tree`,  return desired information. If no
arguments are passed.  `con_id` of acitve window
is returned. If there is more then one criterion,
all of them must be true to get results.

OPTIONS
-------

`-v`|`--version`  
Show version and exit

`-h`|`--help`  
Show this help

`-a`|`--active`  
Currently active window (default)

`-c`|`--class` *CLASS*  
Search for windows with the given class

`-i`|`--instance` *INSTANCE*  
Search for windows with the given instance

`-t`|`--title` *TITLE*  
Search for windows with title.

`-n`|`--conid` *CON_ID*  
Search for windows with the given con_id

`-d`|`--winid` *CON_ID*  
Search for windows with the given window id

`-m`|`--mark` *CON_MARK*  
Search for windows with the given mark

`-o`|`--titleformat` *TTL_FRMT*  
Search for windows with the given titleformat

`-y`|`--sync`  
Synch on. If this option is included,  
script will wait till target window exist.

`-r`|`--ret` [*OUTPUT*]  
*OUTPUT* can be one or more of the following 
characters:   

`t`: title  
`c`: class  
`i`: instance  
`d`: Window ID  
`n`: Con_Id (default)  
`m`: mark  
`w`: workspace  
`a`: is active  
`f`: floating state  
`o`: title format  
`v`: visible state  

EXAMPLES
--------
search for window with instance name sublime_text. Request
workspace, title and floating state.  

``` shell
$ i3get -i sublime_text -r wtf 
1
"~/src/bash/i3ass/i3get (i3ass) - Sublime Text"
user_off
```

Title and tile_format output is always surrounded
with doublequotes.

DEPENDENCIES
------------

i3wm
