
### installation

~~If you are using **Arch linux**, you can install
the i3ass package from [AUR].~~ (AUR is no longer supported, but as of writing this it still "works")

Or follow the instructions below to install from source:  

``` text
$ git clone https://github.com/budlabs/i3ass.git
$ cd i3ass
$ make
# make install
```

#### build dependencies
[GNU make], [Gawk], [bash], [GNU sed](https://www.gnu.org/software/sed/)  
[go-md2man] is needed to **re**-build the manpages (optional)

[go-md2man]: https://github.com/cpuguy83/go-md2man

#### runtime dependencies
[bash], [i3wm], [xdotool], [Gawk]  
