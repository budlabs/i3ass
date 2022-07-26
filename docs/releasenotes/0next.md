#### i3king

**TITLE** new rule type

Triggers on new windows and title change.
Always execute `title_format NEW_TITLE`

Instead of command /REGEX/ TEMPLATE is assumed
TEMPLATE can use `$1,$2,$3...` to access capture groups
from the REGEX.'








#### i3ass

Fixed an issue in `share/main.awk` . Titles containing
a colon (`:`) character where not being captured by
f.i. `i3get -r o`. #174 thanks @DominikMarcinowski

#### i3run

Added `--silent` option

#### i3king

fixed issue where commented lines ending with backslash
concatenated the next line.  

added support for `$ROLE and $TYPE` variables in config.

#### i3get

added `--timeout SECONDS` option. To adjust the timeout
before `--synk` stops waiting for a window (default 60s)


