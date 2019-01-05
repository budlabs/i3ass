---
description: >
  Professional window focus for i3wm
updated:       2019-01-05
version:       0.038
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2018-01-18
dependencies:  [bash, gawk, i3]
see-also:      [bash(1), awk(1), i3(1)]
synopsis: |
    --help|-h
    --version|-v
    [--gap|-g GAPSIZE] **DIRECTION**
    [--focus|-f] --title|-t       [**TARGET**]
    [--focus|-f] --instance|-i    [**TARGET**]
    [--focus|-f] --class|-c       [**TARGET**]
    [--focus|-f] --titleformat|-o [**TARGET**]
    [--focus|-f] --winid|-d       [**TARGET**]
    [--focus|-f] --parent|-p      [**TARGET**]
...

# long_description

`i3viswiz` either prints a list of the currently visible tiled windows to `stdout` or shifts the focus depending on the arguments.  

If a *DIRECTION* (left|right|up|down) is passed, `i3wizvis` will shift the focus to the window closest in the given *DIRECTION*, or warp focus if there are no windows in the given direction.  


