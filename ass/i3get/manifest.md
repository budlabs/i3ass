---
description: >
  Boilerplate and template maker for bash scripts
updated:       2019-01-06
version:       0.328
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2017-03-08
dependencies:  [bash, gawk, i3]
see-also:      [bash(1), awk(1), i3(1)]
synopsis: |
    --help|-h
    --version|-v
    [--class|-c CLASS] [--instance|-i INSTANCE] [--title|-t TITLE] [--conid|-n CON_ID] [--winid|-d WIN_ID] [--mark|-m MARK] [--titleformat|-o TITLE_FORMAT] [--active|-a] [--synk|-y] [--print|-r OUTPUT]      
...

# long_description

Search for `CRITERIA` in the output of `i3-msg -t get_tree`,  
return desired information. 
If no arguments are passed.  
`con_id` of acitve window is returned. 
If there is more then one criterion, 
all of them must be true to get results.

# examples

search for window with instance name sublime_text. 
Request workspace, title and floating state.  

``` shell
$ i3get --instance sublime_text -r wtf 
1
~/src/bash/i3ass/i3get (i3ass) - Sublime Text
user_off
```
