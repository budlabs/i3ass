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
And some of the scripts are rather complex. The links in the
table below, will take you to the wiki page for the script.

|**file**  |     **function**          |
|:---------|:--------------------------|
|[i3flip] | Tabswitching done right
|[i3fyra] | An advanced, simple grid-based tiling layout
|[i3get] | Boilerplate and template maker for bash scripts
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

### v.0.1.7

Added [i3Kornhe]

changed output of [i3viswiz] again, control variables are
now all on the first line. Also added workspace dimensions
for better (not yet perfect) multimonitor support, modified
i3fyra 'move' command to work with the new changes.

Added workspace position to i3list output.

### v.0.1.77


cleaned up [i3flip] code and added ability to flip in
layouts other then tabbed|stacked.

### v.0.1.75


fixed an issue with [i3viswiz] and i3gaps, where the
correct window couldn't be located if the search  ended up
in the gaps. (this can still happen, and might need some
more tweaks, but with this fix it's much less likely to
happen then before.)


## known issues

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
[i3flip]: https://github.com/budlabs/i3ass/wiki/10AS_i3flip
[i3fyra]: https://github.com/budlabs/i3ass/wiki/11AS_i3fyra
[i3get]: https://github.com/budlabs/i3ass/wiki/12AS_i3get
[i3gw]: https://github.com/budlabs/i3ass/wiki/13AS_i3gw
[i3Kornhe]: https://github.com/budlabs/i3ass/wiki/14AS_i3Kornhe
[i3list]: https://github.com/budlabs/i3ass/wiki/15AS_i3list
[i3menu]: https://github.com/budlabs/i3ass/wiki/16AS_i3menu
[i3run]: https://github.com/budlabs/i3ass/wiki/17AS_i3run
[i3var]: https://github.com/budlabs/i3ass/wiki/18AS_i3var
[i3viswiz]: https://github.com/budlabs/i3ass/wiki/19AS_i3viswiz



## license

**i3ass** is licensed with the **MIT license**


