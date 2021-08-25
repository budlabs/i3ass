# i3ass - i3 assistance scripts 


![logo](https://github.com/i3ass-dev/i3ass/blob/dev/assets/i3ass-first-logo2021-05-26-300x200.png?raw=true)  

### a shellscript collection to assist the usage of the [i3wm] windowmanager.


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
i3ass - version: 2021.08.25.3
updated: 2021-08-25 by budRich

script   | version
------------------
i3flip   | 0.101
i3fyra   | 1.13
i3get    | 0.72
i3gw     | 2020.08.12.0
i3king   | 0.23
i3Kornhe | 0.665
i3list   | 0.33
i3menu   | 0.11
i3run    | 0.15
i3var    | 0.050
i3viswiz | 0.52

dependencies:
bash     [INSTALLED]
gawk     [INSTALLED]
i3       [INSTALLED]
i3-msg   [INSTALLED]
rofi     [INSTALLED]
xdotool  [INSTALLED]
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
|[i3king] | window ruler
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

### [i3Kornhe]

Reworked the script to now use a FIFO, which made moving
and resizing a lot more responsive with no lag and much less
stuttering.

### [i3viswiz]


Added debug vars for active window geometry
(`ax,ay,aw,ah`). And active workspace geometry
(`sx,sy,sw,sh`)

### [i3king]


new options: `--conid`, `--print-commands`.  
`--conid CONID` will match a single window against the
rules and exit. `--print-commands` will print the commands
instead of executing them.

**ON_CLOSE** directive added. Rules prefixed like this will
get triggered when windows are closed.

### [i3run]


Commands can now be entered after `--`. The old way of
specifying the command: (`--command|-e`)

``` shell
# old way
i3run --instance sublime_text --command 'subl && notify-send "sublime is started"'

# new way
i3run --instance sublime_text -- subl "&&" notify-send "sublime is started"
```


---


Fixed issue where windows had the wrong floating state when
being sent across workspaces (#99).

### [i3list]


Added ABW and TBW keys to output, with active/target
windows border width.

Fixed issue where wrong workspace ID was reported on empty
workspaces. Also if workspace is empty now container/window
info will NOT get printed.

### [i3fyra]


When using `--float` to toggle a floating window to be
tiled, we check if i3king is running and if the window
matches any of the rules. If a rule matches the
corresponding command is executed instead of *just* making
the window tiled.

### [i3menu]


Added `--list-directory DIRECTORY` option. It is a shortcut
to make a menu listing the filenames in DIRECTORY and
printing the full path to stdout.

### [i3get]


fixed issue where `--synk` option caused the script to halt until a window event occured.

## known issues

**THERE IS NO SUPPORT FOR i3-gaps**  
some scripts might still work with i3-gaps, but consider that *Happy little accidents™*

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
[i3var]: https://github.com/budlabs/i3ass/wiki/i3var
[i3run]: https://github.com/budlabs/i3ass/wiki/i3run
[i3menu]: https://github.com/budlabs/i3ass/wiki/i3menu
[i3viswiz]: https://github.com/budlabs/i3ass/wiki/i3viswiz
[i3king]: https://github.com/budlabs/i3ass/wiki/i3king



## license

**i3ass** is licensed with the **MIT license**


