Search for `CRITERIA` in the output of `i3-msg -t get_tree`,
return desired information.
If no arguments are passed,
`con_id` of active window is returned.
If there is more then one criterion,
all of them must be true to get results.

# EXAMPLES

search for window with instance name sublime_text. 
Request workspace, title and floating state.  

``` shell
$ i3get --instance sublime_text --print wtf 
1
~/src/bash/i3ass/i3get (i3ass) - Sublime Text
user_off
```
