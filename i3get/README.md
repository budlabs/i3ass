
Get information about a window
==============================
Search for windows in i3 tree and print requested information. If no arguments are passed. `con_id` of active window is returned.

usage
-----
``` text
i3get [OPTION CRITERIA]

| option | criteria | function                   |
|:-------|:---------|:---------------------------|
| -v     |          | show version and exit
| -h     |          | show this help
| -a     |          | currently active window (default)
| -c     | CLASS    | search for windows with the given class
| -i     | INSTANCE | search for windows with the given instance
| -t     | TITLE    | search for windows with title.
| -n     | CON_ID   | search for windows with the given con_id
| -d     | CON_ID   | search for windows with the given window id
| -m     | CON_MARK | search for windows with the given mark
| -o     | TTL_FRMT | search for windows with the given titleformat
| -y     |          | synch on. If this option is included, 
|        |          | script will wait till target window exist.

-r [tcidnmw]   desired return.
                t: title
                c: class
                i: instance
                d: Window ID
                n: Con_Id (default)
                m: mark
                w: workspace
                a: is active
                f: floating state
                o: title format
                v: visible state
```

example
---------
``` shell
# Search for window with instance name sublime_text. 
# Request workspace, title and floating state.

$ i3get -i sublime_text -r wtf
  1
  "~/tmp/kortisar/i3ass/doc/i3gw.md (i3ass) - Sublime Text"
  "user_off"
```

