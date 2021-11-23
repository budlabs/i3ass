`i3var` is used to get or set a "variable" that is bound to the current i3wm session. 
The variable is actually the mark on the **root container**.

`set`  \[VALUE\]  
If *VARNAME* doesn't exist,
a new window and mark will be created. 
If *VARNAME* exists, it's value will be replaced with *VALUE*.  
If *VALUE* is not defined, 
*VARNAME* will get unset (the mark is removed).  

`get`  
if *VARNAME* exists, 
its value will be printed to **STDOUT**.  
