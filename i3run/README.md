

*******************************
This is a run or raise or hide script for i3wm.
It looks for a window matching a given criteria.

These are the actions taken depending on the state of the found window:

| **target window state**          | **action**
|:---------------------------------|:-----------------
| Active and not handled by i3fyra | mark and hide
| Active and handled by i3fyra     | do nothing
| Handled by i3fyra and hidden     | show container, activate
| Not handled by i3fyra and hidden | show window, activate
| Not on current workspace         | goto workspace
| Not found                        | run command

Hidden in this context, means that window is on scratchpad/
Show in this context means, move window to current workspace.



**usage**  
`$ i3run -h|v|i|c|t [CRITERIA] [-e COMMAND]`

| **option** | **criteria** | **function**                   |
|:-------|:---------|:---------------------------|
| -v     |          | show version info and exit |
| -h     |          | show this help and exit    |
| -c     | CLASS    | Search for windows with the given CLASS
| -i     | INSTANCE | Search for windows with the given INSTANCE
| -t     | TITLE    | Search for windows with the given TITLE
| -e     | COMMAND  | Command to run if no window is found.
| -s     |          | Instead of switching workspace,
|        |          | summon window to current workspace

it is important that `-e COMMAND` is last of the options.
-e is optional, if no COMMAND is passed and no window is found, nothing happens.
It is also important that COMMAND will spawn a window matching the criteria,
otherwise the script will get stuck in a loop waiting for the window to appear.

dependencies
------------
* [i3list](https://github.com/budRich/i3ass/tree/master/i3list)
* [i3get](https://github.com/budRich/i3ass/tree/master/i3get) 

