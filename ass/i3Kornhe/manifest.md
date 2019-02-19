---
description: >
  move and resize windows gracefully
updated:       2019-02-19
version:       0.033
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2017-12-12
dependencies:  [bash, gawk, i3, i3list, i3var]
see-also:      [bash(1), awk(1), i3(1), i3list(1), i3var(1)]
synopsis: |
    DIRECTION
    move [--speed|-p SPEED] [DIRECTION]
    size [--speed|-p SPEED] [DIRECTION]
    1-9
    x
    --help|-h
    --version|-v
...

# long_description

i3Kornhe provides an alternative way to move and resize windows in **i3**.
It has some more functions then the defaults and is more streamlined.
Resizing floating windows is done by first selecting a corner of the window, 
and then moving that corner. See the wiki or the manpage for details and how
to add the required mode in the i3 config file that is needed to use **i3Kornhe**.
