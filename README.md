# i3ass - i3 assistance scripts 

![logo](assets/i3ass-first-logo2021-05-26-300x200.png)  
This is a collection of scripts I have made to assist the
usage of the windowmanager known as [i3wm].

## installation

If you are using **Arch linux**, you can install the i3ass
package from [AUR].  

Or follow the instructions below to install from source:  

(*configure the installation destination in the Makefile,
if needed*)

``` text
$ git clone https://github.com/budlabs/i3ass.git
$ cd i3ass
# make install
$ i3ass
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


All the scripts that will be installed are located in the
`src` directory of this repo, so you can also just add that
directory or the scripts to your **$PATH**.  

---

There is no oneline way to describe what **i3ass** does.
And some of the scripts are rather complex. The links in the
table below, will take you to the wiki page for the script.


|**file**  |     **function**          |
|:---------|:--------------------------|
|[i3flip] | Tabswitching done right
|[i3fyra] | An advanced, simple grid-based tiling layout
|[i3get] | prints info about a specific window to stdout
|[i3gw] | a ghost window wrapper for i3wm
|[i3Kornhe] | move and resize windows gracefully
|[i3list] | list information about the current i3 session.
|[i3menu] | Adds more features to rofi when used in i3wm
|[i3run] | Run, Raise or hide windows in i3wm
|[i3var] | Set or get a i3 variable
|[i3viswiz] | Professional window focus for i3wm

EXAMPLES
--------

Execute a script with the `--help` flag to display help
about the command.

`i3get --help` display [i3get] help  
`i3get --version` display [i3get] version  
`man i3get` show [i3get] man page  
`i3ass` show version info for all scripts and dependencies.

## updates

### [i3viswiz]

Now works correctly with multiple active monitors.  

#### focusing back and forth in the opposite directions feels more intuitive


When **i3viswiz** is used to shift focus in a direction
(left, right, up, down) the current container ID is noted
(`i3var set`). This is done so that the next time we focus
in a direction we will test if the saved ID is adjacent to
the current container at the searched direction and focus
that if it is the case.


#### less noisy output


when **i3viswiz** is used to output text, it by default
only prints a table representing the visible windows. It now
also prints the workspace number. And all visible windows
from all workspaces not just the active one. Example:  

```text
$ i3viswiz --instance

* 94475856575600 ws: 1 x: 0     y: 0     w: 1558  h: 410   | termsmall
- 94475856763248 ws: 1 x: 1558  y: 0     w: 362   h: 272   | gl
- 94475856286352 ws: 1 x: 0     y: 410   w: 1558  h: 643   | sublime_main
- 94475856449344 ws: 1 x: 1558  y: 272   w: 362   h: 781   | thunar-lna
```


In previous versions of **i3viswiz** the first line of this
output contained additional information that is being used
by other **i3ass** scripts. That info is still available,
but the user needs to use the new `--debug VARLIST` option, 
to get that info. See the manpage or `--help` for more info.


### [i3flip]


Use a lock file to make sure we don't "double execute" the
script. Updated to work with new version of **i3viswiz**.

### [i3fyra]


the value of the environment variable, **I3FYRA_WS**, which
is used to declare which workspace to be used for
**i3fyra**. Is now checked against a workspace name instead
of a workspace number.

`i3-msg open` is not used  in **i3fyra** anymore, this
shuold make the experience smoother and the creation of new
containers faster.

### [i3Kornhe]


Added 5 new commanline options to set the screenmargin size
when moving windows in direction [1-9].

Removed the use of `i3-msg open` and use a more robust
method for keeping track of the active window, previous
versions someimes changed the titleformat of the wrong
windows becuase of the old method.

### [i3list]


It is now possible to use multiple criteria for windows.

The output is printed in a better organized way.  
Two new keys added to the output array:

```
i3list["RID"] # root container id
i3list["ORI"] # i3fyra orientation
```


### [i3menu]


Improved the way i3menu reads from STDIN. Large lists
(10000+ lines) loads much faster now.

### [i3var]


Add variables as marks on the root container instead of
creating separate empty windows with `i3-msg open` for each
mark.


## known issues

**THERE IS NO SUPPORT FOR i3-gaps**  
some scripts might still work with i3-gaps, but consider
that *Happy little accidents™*  

The latest version of i3 (**4.19**) introduced a new
behaviour that triggers `for_window` directives when a
window is sent to the scratchpad. This is very annoying if
one would use something like:  
`for_window [instance=Install_gentoo] exec i3fyra --move A`  
I recommend anyone using `for_window` to stick with version
**4.18.3**, till this is resolved..  

`i3-msg restart` breaks [i3fyra], try to use `i3-msg
reload` instead (*it's faster and usually works just as good
as restart*).



[wiki]: https://github.com/budlabs/i3ass/wiki
[Makefile]: https://github.com/budRich/i3ass/blob/master/Makefile
[install.sh]: https://github.com/budRich/i3ass/blob/master/install.sh
[i3add]: https://github.com/budRich/scripts/i3add/
[AUR]: https://aur.archlinux.org/packages/i3ass/
[i3]: https://i3wm.org/
[i3wm]: https://i3wm.org/
[bashbud]: https://github.com/budlabs/bashbud
[i3flip]: https://github.com/budlabs/i3ass/wiki/i3flip
[i3fyra]: https://github.com/budlabs/i3ass/wiki/i3fyra
[i3get]: https://github.com/budlabs/i3ass/wiki/i3get
[i3gw]: https://github.com/budlabs/i3ass/wiki/i3gw
[i3Kornhe]: https://github.com/budlabs/i3ass/wiki/i3Kornhe
[i3list]: https://github.com/budlabs/i3ass/wiki/i3list
[i3menu]: https://github.com/budlabs/i3ass/wiki/i3menu
[i3run]: https://github.com/budlabs/i3ass/wiki/i3run
[i3var]: https://github.com/budlabs/i3ass/wiki/i3var
[i3viswiz]: https://github.com/budlabs/i3ass/wiki/i3viswiz



## license

**i3ass** is licensed with the **MIT license**


