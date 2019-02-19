---
description: >
  Run, Raise or hide windows in i3wm
updated:       2019-02-19
version:       0.041
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2017-04-20
dependencies:  [bash,gawk,i3list,i3get,i3var,xdotool,i3fyra,i3]
see-also:   [bash(1), awk(1), i3list(1), i3get(1), i3var(1), xdotool(1), i3fyra(1)]
environment-variables:
    I3RUN_BOTTOM_GAP: 10
    I3RUN_TOP_GAP: 10
    I3RUN_LEFT_GAP: 10
    I3RUN_RIGHT_GAP: 10
    I3FYRA_WS: X
synopsis: |
    --instance|-i INSTANCE [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--command|-e COMMAND]
    --class|-c CLASS [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--command|-e COMMAND]
    --title|-t  TITLE [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--command|-e COMMAND]
    --conid|-n CON_ID [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--command|-e COMMAND]
    --help|-h
    --version|-v
...


# long_description

`i3run` let's you use one command for multiple functions related to the same window identified by a given criteria. 
`i3run` will take different action depending on the state of the searched window:  

| **target window state**          | **action**
|:---------------------------------|:------------
| Active and not handled by i3fyra | hide
| Active and handled by i3fyra     | hide container, if not `-g` is set
| Handled by i3fyra and hidden     | show container, activate
| Not handled by i3fyra and hidden | show window, activate
| Not on current workspace         | goto workspace or show if `-s` is set
| Not found                        | execute command (`-e`)


Hidden in this context, 
means that window is on the scratchpad.
Show in this context means, 
move window to current workspace.  


`-e` is optional, if no *COMMAND* is passed and no window is found, 
nothing happens. 
It is important that `-e` *COMMAND* is **the last of the options**. 
It is also important that *COMMAND* **will spawn a window matching the criteria**, 
otherwise the script will get stuck in a loop waiting for the window to appear.
(*it will stop waiting for the window to appear after 10 seconds*)
