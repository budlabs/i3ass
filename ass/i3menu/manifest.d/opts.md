# options-theme-description

If a **.rasi** file with same name as THEME exist in `I3MENU_DIR/themes`, it's content will get appended to theme file before showing the menu.  

`$ echo "list" | i3menu --theme red`  
this will use the the file: `I3MENU_DIR/themes/red.rasi`

If no matching themefile is found, `I3MENU_DIR/themes/default.rasi` will be used 
(and created if it doesn't exist).

# options-include-description

INCLUDESTRING can be set to force which elements of the menu to include.
INCLUDESTRING can be one or more of the following character:  

| char | element  |
|:-----|:---------|
|**p** | prompt   |
|**e** | entrybox |
|**l** | list     |

`echo "list" | i3menu --include le --prompt "enter a value: "`  
The command above will result in a menu without the **prompt** element.  

`i3menu --include pe --prompt "enter a value: "`  
The command above will result in a menu without a **list** element. (just an inputbox).  

It's also worth mentioning that **i3menu** adapts to the objects it knows before creating the menu. This means that if no input stream (list) exist, no list element will be included, the same goes for the prompt.  

# options-top-description

If TOP is set, the input stream (LIST) will get matched against TOP.
Lines in LIST with an exact MATCH of those in TOP will get moved to the TOP of LIST before the menu is created.


`$ printf '%s\n' one two three four | i3menu --top "$(printf '%s\n' two four)"`  

will result in a list looking like this:  
`two four one three`


# options-width-description

Changes the width of the menu. If the argument to `--width` ends with a `%` character the width will be that many percentages of the screenwidth. Without `%` absolute width in pixels will be set.

# options-options-description

The argument is a string of aditional options to pass to **rofi**.  

`$ i3menu --prompt "Enter val: " --options '-matching regex'`  
will result in a call to rofi looking something like this:  
`rofi -p "Enter val: " -matching regex -dmenu`

Note that the **rofi** options: `-p, -filter, -show, -modi` *could be* entered to as arguments to `i3menu --options`, but it is recommended to use: `--prompt`, `--filter`, `--show` and `--modi` instead, since this will make i3menu optimize the layout better.

# options-prompt-description

Sets the prompt of the menu to PROMPT.

# options-layout-description

This is where **i3menu** differs the most from normal **rofi** behavior and is the only option that truly depends on `i3`, `i3list` (and **i3fyra** if the value is A|B|C|D). If this option is not set, the menu will default to a single line (*dmenu like*) menu at the top of the screen. If however a value to this option is one of the following:  

| LAYOUT     | menu location and dimensions 
|:-----------|:---------------
| mouse      | At the mouse position (requires `xdotool`)
| window     | The currently active window.
| titlebar   | The titlebar of the currently active window.
| tab        | The tab (or titlebar if it isn't tabbed) of the currently active window.
| A,B,C or D | The **i3fyra** container of the same name if it is visible. If target container isn't visible the menu will be displayed at the default location.

titlebar and tab LAYOUT will be displayed as a single line (*dmenu like*) menu, and the other LAYOUTS will be of vertical (*combobox*) layout with the prompt and entrybox above the list.  

The position of the menu can be further manipulated by using `--xpos`,`--ypos`,`--width`,`--height`,`--orientation`,`--include`.  

`$ echo "list" | i3menu --prompt "select: " --layout window --xpos -50 --ypos 30`  
The command above would create a menu with the same size and position as the current window, but place it 50px to the left of the window, and 30px below the *lower* of the window.

# options-filter-description

Sets the inputbox text/filter to FILTER. Defaults to blank string.

# options-show-description

This is a short hand for the **rofi** option `-show`. So instead of doing this:  
`$ i3menu -o '-show run'` , you can do this:  
`$ i3menu --show run`

# options-modi-description

This is a short hand for the **rofi** option `-modi`. So instead of doing this:  
`$ i3menu -o '-modi run,drun -show run'` , you can do this:  
`$ i3menu --modi run,drun --show run`

# options-xpos-description

Sets the **X** position of the menu to INT. If this option is set, it will override any automatic position of the **X** coordinate.

# options-xoffset-description

Adds INT to the calculated **X** position of the menu before it is displayed. XPOS can be either positive or negative.

**EXAMPLE**  
If both `--layout` is set to `window` and `--xpos` is set to `-50`, the menu will be placed 50 pixels to the left of the active window but have the same dimensions as the window.

# options-ypos-description

Sets the **Y** position of the menu to INT. If this option is set, it will override any automatic position of the **Y** coordinate.

# options-yoffset-description

Adds INT to the calculated **Y** position of the menu before it is displayed. INT can be either positive or negative.

**EXAMPLE**  
If both `--layout` is set to `titlebar` and `--ypos` is set to `50`, the menu will be placed 50 pixels below the active window.

# options-target-description

TARGET is a string containing additional options passed to **i3list**.
This can be used to change the target window when `--layout` is set to:
`window`,`titlebar` or `tab`.

# options-orientation-description

This forces the layout of the menu to be either vertical or horizontal. If `--layout` is set to **window**, the layout will always be `vertical`.

# options-anchor-description

Sets the "*anchor*" point of the menu. The default is **1**. **1** means the top left corner, **9** means the bottom right corner. Corner in this context doesn't refer to the corners of the screen, but the corners of the menu. If the anchor is *top left* (**1**), the menu will *grow* from that point.

# options-height-description

Overrides the calculated height of the menu.

# options-fallback-description

FALLBACK can be a string of optional options the will be tried if the *first layout* fails. A layout can fail of three reasons:

1. layout is window or container, but no list is passed. If no fallback is set, **titlebar** layout will get tried.
2. layout is container but container is not visible. If no fallback is set, **default** layout will get tried.
3. layout is window, tab or titlebar but no target window is found. If no fallback is set, **default** layout will get tried.

**Example**  
```text
$ echo -e "one\ntwo\nthree" | i3menu --layout A --fallback '--layout mouse --width 300'
```

The example above will display a menu at the mouse pointer if container A isn't visible.

Fallbacks can be nested, but make sure to alternate quotes:  

```text
$ echo -e "one\ntwo\nthree" | i3menu --layout A --fallback '--layout window --fallback "--layout mouse --width 300"'
```

The example above would first try to display a menu with `--layout A` if that fails, it will try a menu with `--layout window` and last if no target window can be found, the menu will get displayed at the mouse pointer.

# options-help-description
Show help and exit.

# options-version-description
Show version and exit
