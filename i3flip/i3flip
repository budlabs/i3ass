#!/bin/bash

NAME="i3flip"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2018-01-03"
UPDATED="2018-01-03"

main(){
  while getopts :vh option; do
    case "${option}" in
      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;
      h|*) printinfo && exit ;;
    esac
  done

  dir="$1"

  case "$dir" in
    n|next ) dir=n ;;
    p|prev ) dir=p ;;
    ''|*   ) dir=n ;;
  esac

  alst=($(getwindow))
  # "n"|"t
  pos=${alst[0]%|*}
  tot=${alst[0]#*|}

  [[ $tot = 1 ]] && exit

  [[ $dir = n ]] \
    && trg=$((pos==tot?1:pos+1)) \
    || trg=$((pos==1?tot:pos-1))

  i3-msg -q "[con_id=${alst[$trg]}]" focus
}

getwindow(){
  i3-msg -t get_tree \
  | awk -v RS=',' -F':' -v crit='"focused"' -v srch="true" \
    'BEGIN{fid="0";nid="0";nfo="0"}
      $1~"{\"id\"" {cid=$2;nid=nid+1;aid[nid]=cid}
      $2~"\"id\"" {cid=$3;nid=nid+1;aid[nid]=cid}
      $1 ~ crit && $2 ~ srch  {fid=cid}
      $2 ~ crit && $3 ~ srch  {fid=cid}
      fid!="0" && $1=="\"focus\"" && $2~fid{focs=1}
      focs=="1" {nfo=nfo+1}
      focs=="1" && $NF~"[]]$" {
        j=0
        t=((nid)-(nid-nfo))
        n=1
        for (i=nid-nfo+1; i <= nid; i++){
          j++
          if(t>1 && fid==aid[i]){n=j}
          thelist=thelist" "aid[i]
        }
        
        print n"|"t thelist
        exit
      } '
}

printinfo(){
  case "$1" in
    m ) printf '%s' "${about}" ;;
    
    f ) 
      printf '%s' "${bouthead}"
      printf '%s' "${about}"
      printf '%s' "${boutfoot}"
    ;;

    ''|* ) 
      printf '%s' "${about}" | awk '
         BEGIN{ind=0}
         $0~/^```/{
           if(ind!="1"){ind="1"}
           else{ind="0"}
           print ""
         }
         $0!~/^```/{
           gsub("[`*]","",$0)
           if(ind=="1"){$0="   " $0}
           print $0
         }
       '
    ;;
  esac
}

bouthead="
${NAME^^} 1 ${CREATED} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${AUTHOR} <${CONTACT}>
<https://budrich.github.io>

SEE ALSO
--------

bar(1), foo(5), xyzzy(1), [Linux Man Page Howto](
http://www.schweikhardt.net/man_page_howto.html)
"

about='
`i3flip` - Tabswitching done right

SYNOPSIS
--------

`i3flip` [`-v`|`-h`] [n|next|p|prev]

DESCRIPTION
-----------

`i3flip` switch containers without leaving the parent.
Perfect for tabbed or stacked layout, but works on all
layouts. If direction is `next` (or `n`) and the active
container is the last, the first container will be activated.

OPTIONS
-------

`-v`
  Show version and exit.

`-h`
  Show help and exit.


EXAMPLE
-------

Put these keybinding definitions in the i3 config.  

`~/.config/i3/config`:  
``` text
bindsym Mod4+Tab         exec --no-startup-id i3flip n
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip p
```

Mod4/Super/Windows+Tab will switch to the next tab.

'

if [ "$1" = "md" ]; then
  printinfo m
  exit
elif [ "$1" = "man" ]; then
  printinfo f
  exit
else
  main "${@}"
fi
