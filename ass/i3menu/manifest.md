---
description: >
  Adds more features to rofi when used in i3wm
updated:       2019-02-19
version:       0.015
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2018-07-21
type:          default
dependencies:  [bash, gawk, rofi, i3list, xdotool]
see-also:      [bash(1), awk(1), rofi(1), rofi-theme(1), i3list(1), xdotool(1)]
environ:
    I3MENU_DIR: $XDG_CONFIG_HOME/i3menu
synopsis: |
    [--theme THEME] [--layout|-a LAYOUT] [--include|-i INCLUDESTRING] [--top|-t TOP] [--xpos|-x INT] [--xoffset INT] [--ypos|-y INT] [--yoffset INT] [--width|-w INT] [--options|-o OPTIONS] [--prompt|-p PROMPT]  [--filter|-f FILTER] [--show MODE] [--modi MODI] [--target TARGET] [--orientation ORIENTATION] [--anchor INT] [--height INT] [--fallback FALLBACK]
    --help|-h
    --version|-v
...
 
# long_description

`i3menu` wraps the options i use the most with `rofi` 
and make it easy to set different color schemes
and positions for the menu.  

Every line in `stdin` will be displayed as a menu item. 
The order will be the same as entered if not `--top` is set.  

The foundation for the appearance of the menus are the themefiles 
**i3menu.rasi**,**themevars.rasi**, found in I3MENU_DIR (defaults to $XDG_CONFIG_HOME/i3menu), but depending on the options 
passed to `i3menu` certain values of the themefiles 
will get overwritten.  


