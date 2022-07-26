i3king will match all **new** windows against the
rules defined in **I3_KING_RULE_FILE**
(*`~/.config/i3king/rules`*). If a rule matches
the created window, the command associated with
the rule will get passed to `i3-msg`.

The criterias a window can get matched against are  
- **class**
- **instance**
- **title**
- **window_type**
- **window_role**

Use **GLOBAL** rules to match any windows. global
rules can have a **black**list for windows that
will not trigger the rule.

A variant of the GLOBAL rule is **DEFAULT** rules,
which works exactly like GLOBAL rules, except they
only get triggered if the window didn't match any
*"normal"* rules (regular GLOBAL rules are normal).

**ON_CLOSE** work like normal rules but will only
trigger when a window is closed.

Just like in the i3 config the `set` directive is
available, so you can make variables.

Some built in magic variables are avaible in the config:  
  
- $INSTANCE
- $CLASS
- $CONID
- $WINID
- $TITLE

**TITLE** is a rule type that works slightly different
than the others. If triggered it will always execute
the command `title_format NEW_TITLE`. And triggers
on new windows and when a window title changes.

Instead of a command you specify: `[option]/REGEX/ template`
Use `$1,$2,$3...` in the template to expand them to
the corresponding capture group from the regex.

`[option]` is optional and can be either:  
- `~0` remove expanded $HOME/ from NEW_TITLE
  *if this results in empty NEW_TITLE, a single `~` will be used*
- `~1` replace expanded $HOME with `~`

EXAMPLE
-------
```
# assuming the window class is "Thunar" and the window
# title is something like "/home/anon/.config/i3 - Thunar"

TITLE class=Thunar
  /^(.+)\s-\s(Thunar)$/ Filemanager: $2 - $1

# the above will result in NEW_TITLE: 
# Filemanager: Thunar - /home/anon/.config/i3

TITLE class=Thunar
  ~0/^(.+)\s-\s(Thunar)$/ $1

# the above will result in NEW_TITLE: 
# .config/i3

TITLE class=Thunar
  ~1/^(.+)\s-\s(Thunar)$/ $1

# the above will result in NEW_TITLE: 
# ~/.config/i3

```

EXAMPLE
-------

``` text
GLOBAL \
  class=URxvt instance=htop, \
  instance=firefox
    title_format $INSTANCE
```
The above rule will set the title_format to the instance
name of all windows, except a URxvt window with the
instance name htop, and firefox windows.

If $I3_KING_RULES_FILE doesn't exist,
a example rule file will get created. See that
file for details about the syntax.

If you used to have `for_window` rules that triggered
`i3fyra --move` commands. It is recommended to use
the built in varialbe **$CONID** when executing i3fyra:  

EXAMPLE
-------
``` text
# old i3 version:
for_window [instance=qutebrowser] exec --no-startup-id i3fyra --move C

# with i3 king:
instance=qutebrowser
  exec --no-startup-id i3fyra --conid $CONID --move C
```

(*the `--conid` option in i3fyra is brand new*)

If the `restart` command is issued from i3, all
windows lose gets new container IDs, marks are
lost and other more or less strange things might
happen to the layout. Another thing is that all
open IPC sockets are closed and this means that
any ipc subscriber would have to be restarted.
**i3king** will, when the socket is broken, match
all known windows against the rules again, and
automatically restart itself. If you for some
reason don't want this behaviour, try `--no-
restart` and/or `--no-apply` options.

protip
------

Sending USR1 to the i3king process will restart
i3king. Hint: `kill -USR1 $(< "$XDG_RUNTIME_DIR/i3ass/i3king.pid")`
