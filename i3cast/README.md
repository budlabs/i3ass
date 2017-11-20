
usage
-----
just run the script to start the recording run it again to stop and preview the recording and perform action, (save,upload or play again). if no action is selected the recording is deleted. uploaded recordings is also saved.

a notification is shown when upload is complete and a link is put in your clipboard.

**protip**  
`bindsym --release Mod3+Pint exec --no-startup-id i3cast`  

requirements
------------
[i3get](/i3ass/i3get) | to identify and the terminal (urxvt) window
:---|:---
[i3run](/i3ass/i3run) | to run and hide the terminal (urxvt) window
**urxvt**  | terminal emulator
**ffmpeg**  | commandline tool to record media
**curl**   | commandline tool to download and upload stuff
**mpv**    | minimal mediaplayer, used to preview recording
[dmenu](/blog/dmenu) | tool that displays a menu
**xclip**  | tool that handles clipboard events
**xdotool** | needed to send `q` to urxvt, to quit the recording in a proper way
[gif-is-jif](https://github.com/markasoftware/gif-is-jif) | to save and upload gif format (**optional**)


