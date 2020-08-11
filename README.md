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

### 2020.08.11

#### [i3flip]


We now use the output of **i3viswiz** instead of a custom
AWK script. This made everything more reliable and `--move`
function now works as expected in all types of layouts,
(*not just tabbed and stacked as before*). Also added
`--json`, `--verbose` and `--dryrun` options.

#### [i3fyra]


Now keeps track of the *virtual position* of a window. What
this means is that if you have the following window rule
defined in your **i3 config file**:  

```
for_window [instance=irssi class=URxvt] focus;exec --no-startup-id i3fyra --move A
```


And spawn a window matching the criteria it will get
*moved* to the A container, which by default is the top-left
container.  

```
AAB
AAD
CCD
```


Just as before the containers can be toggled and swapped by
using `i3fyra --move DIRECTION` (where direction is
up,down,left or right). And if the A container would have
focus, and we execute `--move left` it would hide the B and
D containers:

```
AAA
AAA
CCC
```


If we in this state would execute `--move right` (while the
A container is focused), it would move the A and C container
to the right and show the B and D containers to the left,
but i3fyra will also internally rename all the containers:  

```
ABB
ABB
CDD
```


This used to mean that if we now would spawn a window
matching our previously defined window rule, it would still
get placed in the top-left container. This is where things
are different now. In **i3list** there are four new keys,
`[VPA],[VPB],[VPC] and [VPD]` which contains a number
between zero and three (0-3). If i3list would get executed
with the scenario above we would get the following results:  

```
i3list[VPA]=1
i3list[VPB]=0
i3list[VPC]=3
i3list[VPD]=2
```


the integers corresponds to the index of the hypothetical
array `a=([0]=A [1]=B [2]=C [3]=D)`, and with this
information we can see that when we want to send a window to
container A, we test the virtual position, and see that A is
positioned at 1 (*B*), be placed in **B** instead. In most
cases this is the desired result, but sometimes it isn't,
and for those cases one can use the `--force` option (which
is new) to ignore the virtual positions. But this is
probably nothing that anyone needs to worry about, and is
more or less only used internally in **i3fyra**, **i3menu**
and **i3run**. This transformation to virtual positions of
the containers also works with the `--layout` option.

A lot of performance and stability improvements has been
done in this update, and toggling layouts and containers now
works much better and predictable.  

**Removed**  `--target` option. I found myself never using
and it just created awkward cornercase issues.  

**Added** `--force`, `--array`, `--verbose` and `--dryrun`
options.

#### [i3get]

Now uses *one* (well, sometimes two ;) single regular
expression test in bash instead of parsing the json with
awk, this made the script twice as fast and also, imo,
easier to maintain and extend. I also added two new
`--print` options, `s` for sticky status, and `e` for
fullscreen status. But the most important change is done to
the `--synk` functionality, which now uses `i3-msg -t
subscribe` instead of a `while true; do sleep 10 ...`, and
it makes everything much more responsive while at the same
time being so much more efficient and nice on system
recourses. Some output is different for example "marks" will
now print the whole *JSON list* (`["mark1","mark2"...]`),
previous behavior was to only show the first mark unqouted.
If no value is found for a requested output (`--print`) a
line looking like:  
`--i3get could not find: m`  
will be printed, previous behavior was to skip the line i
think this new behavior is better especially if one relies
on the order of the output lines.

#### [i3Kornhe]


fixed typo related issue that caused windows not being
moved correctly. All types of containers are now resized and
moved in pixel (px) unit. When **i3fyra** is executed from
this script, the `--array` option is used.

#### [i3list]


No big changes to the script. Added `--json` options and
watch script to help testing and development. As well as a
few new keys to the output array:  

``` shell
i3list["XAB"] # family AB workspace
i3list["XAC"] # family AC workspace
i3list["XCD"] # family CD workspace
i3list["XBD"] # family BD workspace

i3list["VPA"] # virtual position A
i3list["VPB"] # virtual position B
i3list["VPC"] # virtual position C
i3list["VPD"] # virtual position D
```


#### [i3menu]


Added support for i3fyras virtual positions.

#### [i3run]


Only change since last version is to use `i3fyra --force
--array ARRAY` to override the new virtual positions which
are not needed with i3run because it already figures out the
correct container.

#### [i3viswiz]


Support for `--json` option. A lot more information is
printed to the first line, to make things easier for
**i3fyra** and **i3flip**.

### 2020.01.26.5


[i3menu]  
- added `sleep .05` before reading from STDIN. Hopefully fixes issue with list not getting populated.

- Added `XDG_CONFIG_HOME` environment variable default.


[i3run]
- added `--force` and `--FORCE` options. When enabled `command` will get executed even if the window exist.





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


