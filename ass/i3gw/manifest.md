---
description: >
  a ghost window wrapper for i3wm
updated:       2019-02-19
version:       0.174
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2017-01-11
dependencies:  [i3]
see-also:      [i3(1)]
synopsis: |
    MARK
    --help|-h
    --version|-v
...

# long_description

`i3-msg` has an undocumented function: *open*, 
it creates empty containers, 
or as I call them: ghosts. 
Since these empty containers doesn't contain any windows 
there is no instance/class/title to identify them, 
making it difficult to manage them. 
They do however have a `con_id` 
and I found that the easiest way to keep track of ghosts, is to mark them. 
That is what this script does, 
it creates a ghost, 
get its `con_id` and marks it.

# examples

`$ i3gw casper`  

this will create a ghost marked casper, 
you can perform any action you can perform on a regular container.

``` text
$ i3-msg [con_mark=casper] move to workspace 2
$ i3-msg [con_mark=casper] split v
$ i3-msg [con_mark=casper] layout tabbed
$ i3-msg [con_mark=casper] kill
```

the last command (`kill`), destroys the container.
