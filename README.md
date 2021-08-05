# i3ass - i3 assistance scripts 


![logo](https://github.com/i3ass-dev/i3ass/blob/dev/assets/i3ass-first-logo2021-05-26-300x200.png?raw=true)  
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
i3ass - version: 2021.08.04.3
updated: 2021-08-04 by budRich

script   | version
------------------
i3flip   | 0.101
i3fyra   | 1.1
i3get    | 0.7
i3gw     | 2020.08.12.0
i3king   | 0.1
i3Kornhe | 0.5
i3list   | 0.3
i3menu   | 0.1
i3run    | 0.1
i3var    | 0.050
i3viswiz | 0.51

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

### [i3king]

Fixed issue with default and global rules that didn't have blacklists. 

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
[i3var]: https://github.com/budlabs/i3ass/wiki/i3var
[i3run]: https://github.com/budlabs/i3ass/wiki/i3run
[i3menu]: https://github.com/budlabs/i3ass/wiki/i3menu
[i3viswiz]: https://github.com/budlabs/i3ass/wiki/i3viswiz
[i3king]: https://github.com/budlabs/i3ass/wiki/i3king



## license

**i3ass** is licensed with the **MIT license**


