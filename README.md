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

## updates

### 2018.09.21.0

[i3list] fixed issue #32 for real (*i hope ;*) related to
getting workspace name and number of the active workspace if
it is empty.

### 2018.09.20.0


# [i3get] BREAKING CHANGE

leading and trailing doublequotes are now trimmed from all
output (affecting title and titleformat), this might break
script which include the quotes in f.i. regex searched. 

[i3list] fixed issue #32 related to getting workspace name
and number of the active workspace if it is empty.

### 2018.09.15.0


[i3Kornhe]
- refactored code

- fixed issue with title format not reseting

- add longoption support (`--speed`)



## known issues

`i3-msg restart` breaks [i3fyra], try to use `i3-msg
reload` instead (*it's faster and usually works just as good
as restart*).

[i3flip]: https://github.com/budRich/i3ass/tree/dev/i3flip
[i3fyra]: https://github.com/budRich/i3ass/tree/dev/i3fyra
[i3gw]: https://github.com/budRich/i3ass/tree/dev/i3gw
[i3Kornhe]: https://github.com/budRich/i3ass/tree/dev/i3Kornhe
[i3list]: https://github.com/budRich/i3ass/tree/dev/i3list
[i3get]: https://github.com/budRich/i3ass/tree/dev/i3get
[i3run]: https://github.com/budRich/i3ass/tree/dev/i3run
[i3var]: https://github.com/budRich/i3ass/tree/dev/i3var
[i3viswiz]: https://github.com/budRich/i3ass/tree/dev/i3viswiz
[Makefile]: https://github.com/budRich/i3ass/blob/master/Makefile
[install.sh]: https://github.com/budRich/i3ass/blob/master/install.sh
[i3add]: https://github.com/budRich/scripts/i3add/
[AUR]: https://aur.archlinux.org/packages/i3ass/
[i3]: https://i3wm.org/
[i3wm]: https://i3wm.org/

## license

**i3ass** is licensed with the **MIT license**


