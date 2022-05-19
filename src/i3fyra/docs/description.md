The layout consists of four containers:  

``` text
  A B
  C D
```

A container can contain one or more windows. The
internal layout of the containers doesn't matter.
By default the layout of each container is
tabbed.  

A is always to the left of B and D. And always
above C. B is always to the right of A and C. And
always above D.  

This means that the containers will change names
if their position changes.  

The size of the containers are defined by the
three splits: AB, AC and BD.  

Container A and C belong to one family.  
Container B and D belong to one family.  

The visibility of containers and families can be
toggled. Not visible containers are placed on the
scratchpad.  

The visibility is toggled by either using `--show`
or `--hide`. But more often by moving a container
in an *impossible* direction,(*see examples
below*).  

The **i3fyra** layout is only active on one
workspace. That workspace can be set with the
environment variable: `i3FYRA_WS`, otherwise the
workspace active when the layout is created will
be used.  

The benefit of using this layout is that the
placement of windows is more predictable and
easier to control. Especially when using tabbed
containers, which are very clunky to use
with *default i3*.

# examples

If containers **A**,**B** and **C** are visible
but **D** is hidden or none existent, the visible
layout would looks like this:  

``` text
  A B
  C B
```

If action: `--move up` would be executed when
container **B** is active and **D** is hidden.
Container **D** would be shown. If action would
have been: `--move down`, **D** would be shown
but **B** would be placed below **D**, this means
that the containers will also swap names. If
action would have been `--move left` the active
window in B would be moved to container **A**. If
action was `--move right`, **A** and **C** would
be hidden:  

``` text
  B B
  B B
```

If we now `--move left`, **A** and **C**
would be shown again but to the right of **B**,
the containers would also change names, so **B**
becomes **A**, **A** becomes **B** and **C**
becomes **D**:  

``` text
  A B
  A D
```

If this doesn't make sense, check out this
demonstration on youtube:
https://youtu.be/kU8gb6WLFk8

