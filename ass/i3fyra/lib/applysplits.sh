#!/bin/env bash

applysplits(){
  local i tsn tsv par dir mrk

  for i in ${1}; do
    tsn="${i%\=*}" # target name of split
    tsv="${i#*\=}" # target value of split

    if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
      [[ $tsn = AC ]] \
        && par=${i3list[WFH]:-"${i3list[WAH]}"} dir=height mrk=i34XAB \
        || par=${i3list[WFW]:-"${i3list[WAW]}"} dir=width mrk=i34${tsn:0:1}
    else
      [[ $tsn = AB ]] \
        && par=${i3list[WFW]:-"${i3list[WAW]}"} dir=width mrk=i34XAC \
        || par=${i3list[WFH]:-"${i3list[WAH]}"} dir=height mrk=i34${tsn:0:1}
    fi

    ((tsv<0)) && tsv=$((par-(tsv*-1)))

    i3-msg -q "[con_mark=${mrk}]" resize set "$dir" "$tsv" px

    i3list[S${tsn}]=${tsv}
    i3var set "i34M${tsn}" ${tsv}

  done
}
