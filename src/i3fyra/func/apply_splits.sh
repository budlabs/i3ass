#!/bin/env bash

apply_splits(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"
  
  local i tsn dir target sibling layout_string last_layout
  declare -i tsv splitexist size

  if [[ ${_o[layout]} = redo ]]
    then layout_string=${i3list[RED]//:/ }
    else layout_string=$1
  fi

  [[ $layout_string =~ = ]] \
    || ERX "$layout_string is not a valid layout"

  for i in ${layout_string}; do
    tsn=${i%=*} # target split name
    tsv=${i#*=} # target split value

    if [[ $tsn = "${ori[main]}" || $tsn = main ]]; then
      tsn=${ori[main]}
      target="X${ori[fam1]}" # name of split to resize
      dir=${ori[resizemain]} size=${ori[sizemain]}

      # when --layout option is used, invert split
      # if families are inverted
      # container A virtual position (VPA)
      # inverse mainsplit (2|3 || 1|3)
      [[ -n ${_o[layout]} ]] \
        && (( (_isvertical  && i3list[VPA] > 1)    \
           || (!_isvertical && i3list[VPA] % 2) )) \
        && ((tsv *= -1))

      [[ ${i3list[X${tsn}]} ]] && splitexist=1
    else
      target=${tsn:0:1} sibling=${tsn:1:1}
      dir=${ori[resizefam]} size=${ori[sizefam]}

      [[ ${i3list[LVI]} =~ $target && ${i3list[LVI]} =~ $sibling ]] \
        && splitexist=1
    fi

    ((tsv<0)) && tsv=$((size-(tsv*-1)))

    last_layout+="${tsn}=${i3list[S${tsn}]}:"

    ((splitexist)) && {
      # i3list[Sxx] = current/actual split xx
      i3list[S${tsn}]=${tsv}
      sezzy "con_mark=i34${target}" resize set "$dir" "$tsv" px
    }

    # i3list[Mxx] = last/stored    split xx
    # store split even if its not visible
    mark_vars["i34M${tsn}"]=$tsv

  done

  # store last_layout for --layout redo
  [[ ${_o[layout]} ]] && mark_vars["i34RED"]=$last_layout
}
