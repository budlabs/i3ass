#    WE STRICT NOW
###  2023.08.19

Parsing of commandline arguments are stricter
for the following commands:  
 - `i3fyra`
 - `i3Kornhe`
 - `i3viwiz`
 - `i3flip`

The change is related to the issue (#183).
Before this patch f.i. the command: `i3flip perv`  
was valid and would flip the focus in the *previous* direction.
Because only the first character in the argument was used.

Now this will result in an error: `perv` is not a valid direction.
Valid directions for this case would be "prev, p, previous".
Arguments are still case insensitive.

---

A bugfix in `i3king` on the same theme is that, previously
it was possible to define a rule without a command (probably because of a typo/mistake: #207),
and this could lead to unpredictable bad behaviour and issues.
**Now** if a rule is defined without a command, it will be ignored
and proper error messages will be printed.

---

I also fixed the bug related to workspace name of
i3fyra workspace for the 42'nd time.

---

Finally a minor printf debugging improvement where
arguments to `--json` (usually a full `i3-msg -t
get_tree` string) is now replaced with `...` in
debugging stderr output.

---

big thanks to @gmardom and @1ntronaut for reporting
and helping to troublehsoot the issues!
