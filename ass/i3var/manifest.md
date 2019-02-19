---
description: >
  Set or get a i3 variable
updated:       2019-02-19
version:       0.033
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2017-12-22
dependencies:  [bash, gawk, sed, i3, i3gw]
see-also:      [bash(1), awk(1), i3(1), i3gw(1)]
environment-variables:
    ENV_VAR_TEST:  $HOME/.config
synopsis: |
    set VARNAME [VALUE]
    get VARNAME
    --help|-h
    --version|-v
...

# long_description

`i3var` is used to get or set a "variable" that is bound to the current i3wm session. 
The variable is actually the mark of a "ghost window" on the scratch pad.

`set`  \[VALUE\]  
If *VARNAME* doesn't exist,
a new window and mark will be created. 
If *VARNAME* exists it's value will be replaced with *VALUE*.  
If *VALUE* is not defined, 
*VARNAME* will get unset.  

`get`  
if *VARNAME* exists, 
its value will be returned window.  
