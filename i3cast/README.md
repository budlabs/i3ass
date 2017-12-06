
*******************************
Create and upload screen recordings

usage
-----
`$ i3cast [-v|-h]`

| **option** | **argument** | **function**                   |
|:-------|:---------|:---------------------------|
| -v     |          | show version info and exit |
| -h     |          | show this help and exit    |

Just run the script to start the recording 
run it again to stop and preview the recording 
and perform action, (save,upload or play again). 
if no action is selected the recording is deleted. 
uploaded recordings is also saved.  

A notification is shown when upload is complete and 
a link is put in your clipboard.  

**protip**  
`bindsym --release Mod3+Print exec --no-startup-id i3cast`

dependencies
------------
* i3get
* i3run
* urxvt
* ffmpeg
* curl
* mpv
* dmenu
* xclip
* xdotool
* [gif-is-jif](https://github.com/markasoftware/gif-is-jif) to upload as animated gif to gifycat.
*(optional)*

