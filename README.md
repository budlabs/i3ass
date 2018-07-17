
# i3ass - i3 assistance scripts 

This is a collection of scripts I have made to
assist the usage of the windowmanager known as [i3](https://i3wm.org/).  

  - [updates](#updates)
  - [usage](#usage)
  - [examples](#examples)

## installation

If you are using **Arch linux**, you can install the i3ass package from [AUR](https://aur.archlinux.org/packages/i3ass/).  

Or follow the instructions below to install from github:  

[![](https://budrich.github.io/img/awd/assinstafina.gif)](https://budrich.github.io/img/org/assinstafina.gif)

**clone the repository**  
`git clone https://github.com/budRich/i3ass.git`  

**run the installation script**  
*(for further instructions: `./install.sh -h`)*  
`./install.sh`   

There is also a [Makefile](https://github.com/budRich/i3ass/blob/master/Makefile) that you can use if you want more control over the installation. `make` is actually executed from `install.sh`.  

You can execute `install.sh` with `-q DIRECTORY`, where DIRECTORY is where you want the script to create links to all scripts in `i3ass`. If you use this method the *installation* will be quite.

## usage

Execute a script with the `-h` flag to display help about the command. There are also man pages included in the repo that can be installed with `make install-doc` or `install.sh`.

## examples

`i3get -h` display [i3get](https://github.com/budRich/i3ass/tree/master/i3get) help  
`i3get -v` display [i3get](https://github.com/budRich/i3ass/tree/master/i3get) version  

*I have some more or less useful example scripts using **i3ass** in the [i3add](https://github.com/budRich/scripts/i3add/) repository.*


|**file**              |**function**|
|:-----------------------|:-----------|
|[install.sh](https://github.com/budRich/i3ass/blob/master/install.sh)              |Installation script
|[Makefile](https://github.com/budRich/i3ass/blob/master/Makefile)              | -
|[i3fyra](https://github.com/budRich/i3ass/tree/master/i3fyra) |An advanced simple layout         |
|[i3run](https://github.com/budRich/i3ass/tree/master/i3run)   |Run, Raise or hide a window       |
|[i3get](https://github.com/budRich/i3ass/tree/master/i3get)   |Get information about i3          |
|[i3list](https://github.com/budRich/i3ass/tree/master/i3list) |Get lots of information about i3  |
|[i3gw](https://github.com/budRich/i3ass/tree/master/i3gw)     |Ghost window wrapper script       |
|[i3flip](https://github.com/budRich/i3ass/tree/master/i3flip)   |Tabswitching done right
|[i3viswiz](https://github.com/budRich/i3ass/tree/master/i3viswiz)   |Focus switching and visible-window-info
|[i3var](https://github.com/budRich/i3ass/tree/master/i3var)    |Set or get a i3 variable


## updates

changed output of i3visiz again, control variables are now all on the first line. Also added workspace dimensions for better (not yet perfect) multimonitor support, modified i3fyra 'move' command to work with the new changes.

### v.0.1.66

Added error message to install.sh, if the command is not valid.

### v.0.1.65 - new stuff

Workspace name is added to the [i3list](https://github.com/budRich/i3ass/tree/master/i3list) output (i3list[WAN] and i3list[TAN]), these are used in i3run when a window is summoned. Summoning to a number created an new workspace if it had a name.  

`-t` flag added to [i3fyra](https://github.com/budRich/i3ass/tree/master/i3fyra). It takes a string with options that are passed to i3list, making it possible to target other windows then the active one.

### v.0.1.65 - fixed stuff
Above mentioned thing with i3run and workspace names.  
[i3viswiz](https://github.com/budRich/i3ass/tree/master/i3viswiz) focus function no works.
Negative splitsizes works when splits are manipulated in i3fyra outside the apllysplits function.

### v.0.1.6 - new installation scripts

Added [Makefile](https://github.com/budRich/i3ass/blob/master/Makefile) and updated [install.sh](https://github.com/budRich/i3ass/blob/master/install.sh) to include (*optional*) systemwide and manpage installation.

### v.0.1.6 - [i3list](https://github.com/budRich/i3ass/tree/master/i3list)

**Breaking change**  
Complete rewrite, script is faster and output is more readable and usable (*array format*). If you have scripts relying on i3list, you need to make changes.  

### v.0.1.6 - [i3viswiz](https://github.com/budRich/i3ass/tree/master/i3viswiz)  
**Breaking change**  
Changed output format and added more options to output. Focusing works as before, but if you have scripts that relies on the output (`-p`), you might need to update your scripts.  

### v.0.1.6 - [i3fyra](https://github.com/budRich/i3ass/tree/master/i3fyra)
**Code cleanup**  
Made a big code cleanup and removed big chunks are now handled by i3var,i3viswiz and i3list. Added more comments to the code and made the whole thing more stable, I hope this will resolve many issues that some users have reported. No breaking changes or new features.

### v.0.1.6 - [i3run](https://github.com/budRich/i3ass/tree/master/i3run)

**improvements**  
Adapted the script to use the new i3list which resulted in faster execution times.  

**new options**    

  - `-m` position floating window at cursor (*was default in previous version*)  
  - `-x OLDNAME` rename new windows when they are created.

### v.0.1.6 - [i3flip](https://github.com/budRich/i3ass/tree/master/i3flip)

**direction arguments**  
More directions then p,n,prev,next are now allowed. up, left, prev, u, l, p all do the same thing. Same with: down, right, next, d, r, n.    

## license

All **i3ass** scripts are licensed with the **MIT license**


