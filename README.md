# i3ass  

commands to assist and extend the use of i3wm.

![logo](assets/i3ass-first-logo2021-05-26-300x200.png?raw=true)    

### installation

If you are using **Arch linux**, you can install
the i3ass package from [AUR].

Or follow the instructions below to install from source:  

``` text
$ git clone https://github.com/budlabs/i3ass.git
$ cd i3ass
$ make
# make install
```

#### build dependencies
[GNU make], [Gawk], [bash], [GNU sed](https://www.gnu.org/software/sed/)  

#### runtime dependencies
[bash], [i3wm], [xdotool], [Gawk]  
[rofi] (*only used by [i3menu]*)  

### changelog

See the [last releasenote](docs/releasenotes/0next.md).

### usage

The table below lists the included commands. The
links go to the **[wiki]** page of each commands. 
There is also a lot of videos on the budlabs [youtube channel],
where i3ass is used and explained.

In the **[wiki]** there are also two examples on how
i3's config file can be configured to make use
of most of **i3ass**.  
(<https://github.com/budlabs/i3ass/wiki/i3-config-example>)  


script | description
|:-|:-|
[i3flip] | Tabswitching done right  
[i3fyra] | An advanced, simple grid-based tiling layout  
[i3get] | prints info about a specific window to stdout  
[i3gw] | a ghost window wrapper for i3wm  
[i3king] | window ruler  
[i3Kornhe] | move and resize windows gracefully  
[i3list] | list information about the current i3 session  
[i3menu] | Adds more features to rofi when used in i3wm  
[i3run] | Run, Raise or hide windows in i3wm  
[i3var] | get or get a i3 variable  
[i3viswiz] | professional window focus for i3wm  
[i3zen] | zentered container, full focus  

### known issues

#### **NO SUPPORT FOR i3-gaps**  
Some **i3ass** scripts does not work with i3-gaps,
that is the reason `i3-gaps` is listed as a conflict
in the PKGBUILD on [AUR].

### license

i3ass is licensed under the **MIT** license


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
[i3zen]: https://github.com/budlabs/i3ass/wiki/i3zen
[youtube channel]: https://youtube.com/c/dubbeltumme
[rofi]: https://github.com/davatorium/rofi
[Gawk]: https://www.gnu.org/software/gawk/
[bash]: https://www.gnu.org/software/bash/
[lowdown]: https://kristaps.bsd.lv/lowdown/
[GNU make]: https://www.gnu.org/software/make/
[xdotool]: https://www.semicomplete.com/projects/xdotool/
