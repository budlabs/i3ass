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
And some of the scripts are rather complex, To get an idea I
suggest taking a look in the [wiki] or the individual readme
files for each script (linked in the table below).

|**file**  |     **function**          |
|:---------|:--------------------------|
|[i3flip] | Tabswitching done right
|[i3fyra] | An advanced, simple grid-based tiling layout
|[i3get] | Boilerplate and template maker for bash scripts
|[i3gw] | a ghost window wrapper for i3wm
|[i3Kornhe] | move and resize windows gracefully
|[i3list] | list information about the current i3 session.
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

### 2019.01.30.2

Fixed two bugs (#46,#47) in [i3fyra] and [i3list]. `--hide`
in [i3fyra] now works again. The issue in [i3list] was
affecting targeted windows and their floating state, 
resulting in unpredictable behavior when  fi summoning a
window from the scratchpad.  All should be good now thanks
to user **APotOfSoup** who reported and found the solution
to both these issues. (the cause was the major refactoring
and adaptation of the codebase to the `bashsbud` framework,
introduced in the last release).

### 2019.01.15.0


Removed execution of `i3ass` command from the **Makefile**,
and added `make uninstall` to the **PKGBUILD** on [AUR]. To
improve the installation process. (*thanks to Johan for
reporting issue with i3ass command in makefil*).

### 2019.01.11.0


Extreme refactoring edition.  
The project now uses [bashbud] as the backbone for code and
documentation organization. A lot of changes "under the
hood" and to documentation, but few functional changes
except:  

A new command will get installed, `i3ass`, when executed a
list of installed i3 ass scripts, their version number and
dependencies will get printed. Please include this output in
any submitted issues.

[i3fyra] Should now work well with the latest (4.16)
version of [i3]. A new environment variable can be set for
i3fyra, **I3FYRA_ORIENTATION**, setting this to 'vertical'
changes the layout, read more in the [wiki].  

[i3viswiz] No includes `--focus` option, that will replace
the previous `focusvisible` command. Likewise specifying a
search option (`--title`, `--instance`, `--parent`,
`--class`, `--winid`, `--parent`, `--titleformat`) and a
search string, will return the **CON_ID** of any found
visible window, replacing `getvisible` command. If no search
string is passed, a list of all visible tiles windows and a
string representing the search option will be displayed.

EXAMPLE
-------


```text
i3viswiz --class
trgcon=94759781247616 trgx=0 trgy=0 wall=none trgpar=A sx=0 sy=0 sw=1080 sh=1920
* 94759781247616 x: 0     y: 0     w: 514   h: 399   | URxvt
- 94759780179248 x: 515   y: 0     w: 564   h: 399   | Pavucontrol
- 94759779366272 x: 0     y: 400   w: 1079  h: 1519  | Sublime_text
```


Starting with this release a [wiki] for i3ass is available
here on github.


## known issues

`i3-msg restart` breaks [i3fyra], try to use `i3-msg
reload` instead (*it's faster and usually works just as good
as restart*).

[wiki]: https://github.com/budlabs/i3ass/wiki
[i3flip]: https://github.com/budRich/i3ass/tree/dev/ass/i3flip
[i3fyra]: https://github.com/budRich/i3ass/tree/dev/ass/i3fyra
[i3gw]: https://github.com/budRich/i3ass/tree/dev/ass/i3gw
[i3Kornhe]: https://github.com/budRich/i3ass/tree/dev/ass/i3Kornhe
[i3list]: https://github.com/budRich/i3ass/tree/dev/ass/i3list
[i3get]: https://github.com/budRich/i3ass/tree/dev/ass/i3get
[i3run]: https://github.com/budRich/i3ass/tree/dev/ass/i3run
[i3var]: https://github.com/budRich/i3ass/tree/dev/ass/i3var
[i3viswiz]: https://github.com/budRich/i3ass/tree/dev/ass/i3viswiz
[Makefile]: https://github.com/budRich/i3ass/blob/master/Makefile
[install.sh]: https://github.com/budRich/i3ass/blob/master/install.sh
[i3add]: https://github.com/budRich/scripts/i3add/
[AUR]: https://aur.archlinux.org/packages/i3ass/
[i3]: https://i3wm.org/
[i3wm]: https://i3wm.org/
[bashbud]: https://github.com/budlabs/bashbud

## license

**i3ass** is licensed with the **MIT license**


