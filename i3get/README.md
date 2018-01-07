

`i3get` - Return information about i3wm.

SYNOPSIS
--------

`i3get` [`-h`|`-v`] [`OPTION` [*CRITERIA*]] [`-r` [tcidnmwafov]] [`-y`]

DESCRIPTION
-----------

Search for `CRITERIA` in the output of `i3-msg -t get_tree`, 
return desired information. If no arguments are passed. 
`con_id` of acitve window is returned.

OPTIONS
-------

`-v`  
  Show version and exit

`-h`  
  Show this help

`-a`  
  Currently active window (default)

`-c` *CLASS*  
  Search for windows with the given class

`-i` *INSTANCE*  
  Search for windows with the given instance

`-t` *TITLE*  
  Search for windows with title.

`-n` *CON_ID*  
  Search for windows with the given con_id

`-d` *CON_ID*  
  Search for windows with the given window id

`-m` *CON_MARK*  
  Search for windows with the given mark

`-o` *TTL_FRMT*  
  Search for windows with the given titleformat

`-y`  
  Synch on. If this option is included, 
  script will wait till target window exist.

`-r` [*OUTPUT*]  
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
`i3get -i sublime_text -r wtf`  

Title and tile_format output is always surrounded
with doublequotes.

DEPENDENCIES
------------

i3wm
