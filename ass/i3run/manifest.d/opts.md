# options-class-description
Search for windows with the given CLASS

# options-instance-description
Search for windows with the given INSTANCE

# options-title-description
Search for windows with the given TITLE

# options-conid-description
Search for windows with the given CON_ID

# options-command-description
Command to run if no window is found.
Complex commands can be written inside quotes:  
```
i3run -i sublime_text -e 'subl && notify-send "sublime is started"'
```

# options-summon-description
Instead of switching workspace,
summon window to current workspace

# options-nohide-description
Don't hide window/container if it's active.

# options-mouse-description
The window will be placed on the location of the mouse cursor when it is created or shown. (*needs `xdotool`*)  

# options-rename-description
If the search criteria is `-i` (instance), the window with instance: *OLDNAME* will get a n new instance name matching the criteria when it is created (*needs `xdotool`*).  

```shell
i3run --instance budswin --rename sublime_main -command subl

# when the command above is executed:
# a window with the instance name: "budswin" will be searched for.
# if no window is found the command: "subl" will get executed,
# and when a window with the instance name: "sublime_main" is found,
# the instance name of that window will get renamed to: "budswin"
```


# options-help-description
Show help and exit.

# options-version-description
Show version and exit.
