# i3get - Boilerplate and template maker for bash scripts 

### usage

```text
i3get [--class|-c CLASS] [--instance|-i INSTANCE] [--title|-t TITLE] [--conid|-n CON_ID] [--winid|-d WIN_ID] [--mark|-m MARK] [--titleformat|-o TITLE_FORMAT] [--active|-a] [--synk|-y] [--print|-r OUTPUT]      
i3get --help|-h
i3get --version|-v
```

Search for `CRITERIA` in the output of `i3-msg -t
get_tree`, return desired information. If no arguments are
passed. `con_id` of acitve window is returned. If there is
more then one criterion, all of them must be true to get
results.


OPTIONS
-------

`--class`|`-c` CLASS  
Search for windows with the given class

`--instance`|`-i` INSTANCE  
Search for windows with the given instance

`--title`|`-t` TITLE  
Search for windows with title.

`--conid`|`-n` CON_ID  
Search for windows with the given con_id

`--winid`|`-d` WIN_ID  
Search for windows with the given window id

`--mark`|`-m` MARK  
Search for windows with the given mark

`--titleformat`|`-o` TITLE_FORMAT  
Search for windows with the given titleformat

`--active`|`-a`  
Currently active window (default)

`--synk`|`-y`  
Synch on. If this option is included,  script will wait
till target window exist. (*or timeout after 10 seconds*).

`--print`|`-r` OUTPUT  
*OUTPUT* can be one or more of the following  characters:  

|character | print
|:---------|:-----
|`t`       | title  
|`c`       | class  
|`i`       | instance  
|`d`       | Window ID  
|`n`       | Con_Id (default)  
|`m`       | mark  
|`w`       | workspace  
|`a`       | is active  
|`f`       | floating state  
|`o`       | title format  
|`v`       | visible state  

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit

EXAMPLES
--------
search for window with instance name sublime_text.  Request
workspace, title and floating state.  

``` shell
$ i3get --instance sublime_text -r wtf 
1
~/src/bash/i3ass/i3get (i3ass) - Sublime Text
user_off
```



