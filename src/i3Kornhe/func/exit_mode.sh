#!/usr/bin/env bash

exit_mode(){
  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"

  [[ ${last[conid]} ]] || last[conid]=$(i3get)
  
  messy "mode default"

  # reset title to old title_format or actual title
  messy "[con_id=${last[conid]}]" \
        "title_format ${last[title]:-%title}"
}
