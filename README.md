
# i3ass - i3 assistance scripts 

This is a collection of scripts I have made to
assist the usage of the windowmanager known as i3. 

## installation

[![](https://budrich.github.io/img/awd/assinstafina.gif)](https://budrich.github.io/img/org/assinstafina.gif)

**clone the repository**  
`git clone https://github.com/budRich/i3ass.git`  

**run the installation script**  
*(for further instructions: `./install.sh -h`)*  
`./install.sh`   

## usage

Execute a script with the `-h` flag for help.

## examples

`i3get -h` display [i3get](https://github.com/budRich/i3ass/tree/master/i3get) help  
`i3get -v` display [i3get](https://github.com/budRich/i3ass/tree/master/i3get) version  

*I have some more or less useful example scripts using **i3ass** in the [i3add](https://github.com/budRich/scripts/i3add/) repository.*


|**script**              |**function**|
|:-----------------------|:-----------|
|install.sh              |Installation script
|[i3fyra](https://github.com/budRich/i3ass/tree/master/i3fyra) |An advanced simple layout         |
|[i3run](https://github.com/budRich/i3ass/tree/master/i3run)   |Run, Raise or hide a window       |
|[i3get](https://github.com/budRich/i3ass/tree/master/i3get)   |Get information about i3          |
|[i3list](https://github.com/budRich/i3ass/tree/master/i3list) |Get lots of information about i3  |
|[i3gw](https://github.com/budRich/i3ass/tree/master/i3gw)     |Ghost window wrapper script       |
|[i3flip](https://github.com/budRich/i3ass/tree/master/i3flip)   |Tabswitching done right
|[i3var](https://github.com/budRich/i3ass/tree/master/i3var)    |Set or get a i3 variable


## latest updates:

**new scripts** 
Added [i3flip](https://github.com/budRich/i3ass/tree/master/i3flip) and [i3var](https://github.com/budRich/i3ass/tree/master/i3var).  

**i3fyra**  

Tabswitching function (`-t`) is removed, use [i3flip](https://github.com/budRich/i3ass/tree/master/i3flip) instead, it's both faster and works without i3fyra.
  
I added the ability to pass more then one 
containers to `-z` (hide). All visible containers 
in the string will get hidden. If they are not visible nothing happens. If two of the requested containers are in the same *family/group* (AC|BD) the whole family will get hidden and *remembered*.

**i3run** - new position to mouse   

Floating windows now appears centered to the mouse position, but never outside the screen. Screen borders (gaps) can be fine tuned with environment variables. `xdotool` is a dependency now, it's needed to get the position of the mousecursor. All windows are now hidden if targeted while they are active, if not the new `-g` option is set. Using [i3var](https://github.com/budRich/i3ass/tree/master/i3var) instead of marks.  
**i3list** - window geometry

Added some new output values (45-55) to return the window geometry. Also AWM/TWM (mark) is deprecated, since spaces in marks caused trouble.  

license
-------
All **i3ass** scripts are licensed with the **MIT license**

``` text
Copyright (c) 2017-2018 Nils Kvist

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

