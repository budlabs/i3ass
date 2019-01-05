# i3ass - i3 assistance scripts 

This is a collection of scripts I have made to assist the
usage of the windowmanager known as [i3wm].


[![Sparkline](https://stars.medv.io/budlabs/i3ass.svg)](https://stars.medv.io/budlabs/i3ass)

## installation

If you are using **Arch linux**, you can install the i3ass
package from [AUR]. 

Or follow the instructions below to install from source: 

(*configure the installation destination in the Makefile,
if needed*)

``` shell
$ git clone https://github.com/budlabs/i3ass.git
$ cd i3ass
# make install
$ ./i3ass.sh
i3ass - version: 0.002
updated: 2018-10-18 by budRich

script   | version
------------------
i3viswiz | 0.006
i3get    | 0.302
i3var    | 0.006
i3fyra   | 0.501
i3list   | 0.006
i3flip   | 0.013
i3Kornhe | 0.006
i3gw     | 0.147
i3run    | 0.011

bash      [INSTALLED]
gawk      [INSTALLED]
sed       [INSTALLED]
xdotool   [INSTALLED]

```


### usage

```text
i3ass --help|-h
i3ass --version|-v
```

LONG DESCRIPTION


OPTIONS
-------

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.

---

Execute a script with the `-h` flag to display help about
the command. There are also man pages included in the repo
that can be installed with `make install-doc` or
`install.sh`.

EXAMPLES
--------
`i3get -h` display [i3get] help 
`i3get -v` display [i3get] version 


|**file**  |     **function**          |
|:---------|:--------------------------|
|[i3fyra]  |An advanced simple layout
|[i3run]   |Run, Raise or hide a window
|[i3get]   |Get information about i3
|[i3list]  |Get lots of information about i3 
|[i3gw]    |Ghost window wrapper script
|[i3flip]  |Tabswitching done right
|[i3viswiz]|Focus switching and visible-window-info
|[i3var]   |Set or get a i3 variable
|[i3Kornhe]|move and resize windows gracefully
|[Makefile]| -

## updates

### v.0.1.7

Added [i3Kornhe]

changed output of [i3visiz] again, control variables are
now all on the first line. Also added workspace dimensions
for better (not yet perfect) multimonitor support, modified
i3fyra 'move' command to work with the new changes.

Added workspace position to i3list output.

### v.0.1.6 - new installation scripts


Added [Makefile] and updated [install.sh] to include
(*optional*) systemwide and manpage installation.

### v.0.1.6 - [i3list] 

**Breaking change** 
Complete rewrite, script is faster and output is more
readable and usable (*array format*). If you have scripts
relying on i3list, you need to make changes. 

### v.0.1.6 - [i3viswiz] 
**Breaking change** 
Changed output format and added more options to output.
Focusing works as before, but if you have scripts that
relies on the output (`-p`), you might need to update your
scripts. 

### v.0.1.6 - [i3fyra] 
**Code cleanup** 
Made a big code cleanup and removed big chunks are now
handled by i3var,i3viswiz and i3list. Added more comments to
the code and made the whole thing more stable, I hope this
will resolve many issues that some users have reported. No
breaking changes or new features.

### v.0.1.6 - [i3run] 

**improvements** 
Adapted the script to use the new [i3list] which resulted
in faster execution times. 

**new options**   

- `-m` position floating window at cursor (*was default
in previous version*) 
- `-x OLDNAME` rename new windows when they are created.

### v.0.1.6 - [i3flip]


**direction arguments** 
More directions then p,n,prev,next are now allowed. up,
left, prev, u, l, p all do the same thing. Same with: down,
right, next, d, r, n.   

### v.0.1.66


Added error message to install.sh, if the command is not
valid.


## known issues

`i3-msg restart` breaks [i3fyra], try to use `i3-msg
reload` instead (*it's faster and usually works just as good
as restart*).
[AUR]: https://aur.archlinux.org/packages/i3ass/
[focusvisible]:
https://github.com/budRich/i3ass/tree/master/focusvisible
[getvisible]:
https://github.com/budRich/i3ass/tree/master/getvisible
[i3flip]:
https://github.com/budRich/i3ass/tree/master/i3flip
[i3fyra]:
https://github.com/budRich/i3ass/tree/master/i3fyra [i3gw]:
https://github.com/budRich/i3ass/tree/master/i3gw
[i3Kornhe]:
https://github.com/budRich/i3ass/tree/master/i3Kornhe
[i3list]:
https://github.com/budRich/i3ass/tree/master/i3list [i3get]:
https://github.com/budRich/i3ass/tree/master/i3get [i3run]:
https://github.com/budRich/i3ass/tree/master/i3run [i3var]:
https://github.com/budRich/i3ass/tree/master/i3var
[i3viswiz]:
https://github.com/budRich/i3ass/tree/master/i3viswiz
[Makefile]:
https://github.com/budRich/i3ass/blob/master/Makefile
[install.sh]:
https://github.com/budRich/i3ass/blob/master/install.sh
[i3add]: https://github.com/budRich/scripts/i3add/ [AUR]:
https://aur.archlinux.org/packages/i3ass/ [i3]:
https://i3wm.org/

## license

**i3ass** is licensed with the **MIT license**


