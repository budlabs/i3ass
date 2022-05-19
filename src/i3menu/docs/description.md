
`i3menu` wraps the options i use the most with `rofi` 
and make it easy to set different color schemes
and positions for the menu.  

Every line in `stdin` will be displayed as a menu item. 
The order will be the same as entered if not `--top` is set.  

The foundation for the appearance of the menus are the themefiles 
**i3menu.rasi**,**themevars.rasi**, found in I3MENU_DIR (defaults to $XDG_CONFIG_HOME/i3menu), but depending on the options 
passed to `i3menu` certain values of the themefiles 
will get overwritten.  
