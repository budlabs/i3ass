# i3var - Set or get a i3 variable 

### usage

```text
i3var set VARNAME [VALUE]
i3var get VARNAME
i3var --help|-h
i3var --version|-v
```

`i3var` is used to get or set a "variable" that is bound to
the current i3wm session.  The variable is actually the mark
of a "ghost window" on the scratch pad.

`set`  \[VALUE\]  
If *VARNAME* doesn't exist, a new window and mark will be
created.  If *VARNAME* exists it's value will be replaced
with *VALUE*.  
If *VALUE* is not defined,  *VARNAME* will get unset.  

`get`  
if *VARNAME* exists,  its value will be returned window.  


OPTIONS
-------

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.



