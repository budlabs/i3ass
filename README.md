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

### 2019.03.07.1

grand reorganization of i3ass. created a new GitHub
organization: i3ass-dev. Where all the i3ass scripts have
it's own repo. It's on these repos development will be done
from now on. This (budlabs/i3ass), will be the repo where
all issues should be reported host the wiki and the
installable version of i3ass. I think this will be great.

This repo also contains two fixes to issues reported by
APotOfSoup: i3get reported wrong info when criteria was
**con_id**. and [i3flip] was not moving containers at all
(the latter issue is only partially fixed, moving in
containers that are not tabbed or stacked with i3flip is
temporarily disabled)

more [i3get] fixes: there where some issues related to
special characters in title of a window, and a bug that made
all class searching and fetching not work. both fixed now.


### 2019.02.19.3


Refactored the code for [i3get] to have a standalone `awk`
file and also added better handling of regular expressions
when they are passed as search strings to [i3get]. (*this
might break some scripts that used esacped quotes and
backslashes in the search strings*). You can now write a
search like this: `i3get --instance '^sublime$` the "old"
way of doing it would look something like this: `i3get -i
"sublime\"\$"` and was more unreliable.  

[i3list] had one more of those small issues not reporting
the correct screenheight in some cases, but it is now fixed.

All man pages had a typo that said "Linx manual" instead of
"Linux manual" that is fixed now.



### 2019.02.07.06


Added [i3menu] which is an improved version of the script
`oneliner` that has been available in the **budlabs
organization** for some time. I figured i include it with
**i3ass** instead, since it is very *i3 focused*, see the
wiki for more info.  

Refactored [i3list] to make it easier to manage and fixed a
small issue that resulted in splits being reported with the
wrong size if the *main container* of the split was hidden.
The issue had never caused any serious issues, but now that
it is fixed I experience faster creation of the [i3fyra]
layout, it also made some functions in the new script
[i3menu] work as expected.



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


