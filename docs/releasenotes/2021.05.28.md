### [i3viswiz]

Now works correctly with multiple active monitors.  

#### focusing back and forth in the opposite directions feels more intuitive

When **i3viswiz** is used to shift focus in a
direction (left, right, up, down) the current
container ID is noted (`i3var set`). This is done
so that the next time we focus in a direction we
will test if the saved ID is adjacent to the
current container at the searched direction and
focus that if it is the case.


#### less noisy output

when **i3viswiz** is used to output text, it by default
only prints a table representing the visible windows.
It now also prints the workspace number.
And all visible windows from all workspaces not just
the active one. Example:  

```text
$ i3viswiz --instance

* 94475856575600 ws: 1 x: 0     y: 0     w: 1558  h: 410   | termsmall
- 94475856763248 ws: 1 x: 1558  y: 0     w: 362   h: 272   | gl
- 94475856286352 ws: 1 x: 0     y: 410   w: 1558  h: 643   | sublime_main
- 94475856449344 ws: 1 x: 1558  y: 272   w: 362   h: 781   | thunar-lna
```

In previous versions of **i3viswiz** the first
line of this output contained additional
information that is being used by other **i3ass**
scripts. That info is still available, but the
user needs to use the new `--debug VARLIST`
option,  to get that info. See the manpage or
`--help` for more info.


### [i3flip]

Use a lock file to make sure we don't "double
execute" the script. Updated to work with new
version of **i3viswiz**.

### [i3fyra]

the value of the environment
variable, **I3FYRA_WS**, which is used to declare
which workspace to be used for **i3fyra**. Is now
checked against a workspace name instead of a
workspace number.

`i3-msg open` is not used  in **i3fyra** anymore,
this shuold make the experience smoother and the
creation of new containers faster.

### [i3Kornhe]

Added 5 new commanline options to set the
screenmargin size when moving windows in
direction [1-9].

Removed the use of `i3-msg open` and use a more
robust method for keeping track of the active
window, previous versions someimes changed the
titleformat of the wrong windows becuase of the
old method.

### [i3list]

It is now possible to use multiple criteria for windows.

The output is printed in a better organized way.  
Two new keys added to the output array:

```
i3list["RID"] # root container id
i3list["ORI"] # i3fyra orientation
```

### [i3menu]

Improved the way i3menu reads from STDIN.
Large lists (10000+ lines) loads much faster now.

### [i3var]

Add variables as marks on the root container
instead of creating separate empty windows with
`i3-msg open` for each mark.

