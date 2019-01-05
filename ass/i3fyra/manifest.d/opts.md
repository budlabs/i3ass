# options-float-description

Autolayout. If current window is tiled: floating enabled If window is floating, it will be put in a visible container. If there is no visible containers. The window will be placed in a hidden container. If no containers exist, container 'A'will be created and the window will be put there.

# options-show-description

Show target container. If it doesn't exist, it will be created and current window will be put in it. If it is visible, nothing happens.

# options-move-description


Moves current window to target container, either defined by it's name or it's position relative to the current container with a direction: [`l`|`left`][`r`|`right`][`u`|`up`][`d`|`down`] If the container doesnt exist it is created. If argument is a direction and there is no container in that direction, Connected container(s) visibility is toggled. If current window is floating or not inside ABCD, normal movement is performed. Distance for moving floating windows with this action can be defined with the `--speed` option. Example: `$ i3fyra --speed 30 -m r` Will move current window 30 pixels to the right, if it is floating.

# options-target-description

Criteria is a string passed to i3list to use a different target then active window.  

Example:  
`$ i3fyra --move B --target "-i sublime_text"` this will target the first found window with the instance name *sublime_text*. See i3list(1), for all available options.

# options-speed-description

Distance in pixels to move a floating window. Defaults to 30.

# options-hide-description

Hide target containers if visible.   

# options-layout-description

alter splits Changes the given splits. INT is a distance in pixels. AB is on X axis from the left side if INT is positive, from the right side if it is negative. AC and BD is on Y axis from the top if INT is positive, from the bottom if it is negative. The whole argument needs to be quoted. Example:  
`$ i3fyra --layout 'AB=-300 BD=420'`  


# options-help-description
Show help and exit.

# options-version-description
Show version and exit
