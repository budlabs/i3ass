# readme_banner

This is a collection of scripts I have made to
assist the usage of the windowmanager known as [i3wm]. 

[![Sparkline](https://stars.medv.io/budlabs/i3ass.svg)](https://stars.medv.io/budlabs/i3ass)

# readme_usage

Execute a script with the `-h` flag to display help about the command. There are also man pages included in the repo that can be installed with `make install-doc` or `install.sh`.

# examples

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

# readme_install

If you are using **Arch linux**, you can install the i3ass package from [AUR].  

Or follow the instructions below to install from source:  

(*configure the installation destination in the Makefile, if needed*)

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

# readme_issues

`i3-msg restart` breaks [i3fyra], try to use `i3-msg reload` instead (*it's faster and usually works just as good as restart*).

