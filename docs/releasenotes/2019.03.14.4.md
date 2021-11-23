### 2019.03.14.4

[i3get]  
- fix: issue in resulting in wrong conid being returned.  

[i3menu]  
- fix: removed extra row in vertical menus. 
- fix: less twitchy moving of menu when invoked with mouse and off screen. 
- add: negative position argument for xpos and ypos

**example**  
```
echo list | i3menu --xpos -10 --ypos -20 --width 200 --orientation vertical
this will result in a menu displayed at a position calculated from
the right and bottom edges of the screen.
x=(screenwidth-(menuwidth+xpos))
y=(screenheight-(menuheight+ypos))

if you really want the menu to appear at a "real" negative coordinate (to the left of the left screen edge or above the top), use: --xoffset or --yoffset:

echo list | i3menu \
    --xpos -0 \
    --ypos 0 \
    --width 200 \
    --orientation vertical \
    --yoffset -20 \
    --xoffset 30

 this would place the "top right corner" of the menu, 20 pixels above the active screen and 30 pixels to the right of the active screen.

```





