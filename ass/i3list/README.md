# i3list - list information about the current i3 session. 

### usage

```text
i3list --help|-h
i3list --version|-v
i3list --instance|-i TARGET
i3list --class|-c    TARGET
i3list --conid|-n    TARGET
i3list --winid|-d    TARGET
i3list --mark|-m     TARGET
i3list --title|-t    TARGET
```

`i3list` prints a list in a *array* formatted list.  If a
search criteria is given  (`-c`|`-i`|`-n`|`-d`)  information
about the first window matching the criteria is displayed. 
Information about the active window is always displayed.  If
no search criteria is given,  the active window will also be
the target window.

By using eval,  the output can be used as an array in bash scripts,  but the array needs to be declared first.


OPTIONS
-------

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.

`--instance`|`-i` TARGET  
Search for windows with a instance matching *TARGET*

`--class`|`-c` TARGET  
Search for windows with a class matching *TARGET*

`--conid`|`-n` TARGET  
Search for windows with a **CON_ID** matching *TARGET*

`--winid`|`-d` TARGET  
Search for windows with a **WINDOW_ID** matching *TARGET*

`--mark`|`-m` TARGET  
Search for windows with a **mark** matching *TARGET*

`--title`|`-t` TARGET  
Search for windows with a **title** matching *TARGET* 



