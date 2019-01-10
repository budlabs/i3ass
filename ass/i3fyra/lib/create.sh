#!/bin/env bash

layoutcreate(){
  local trg fam

  trg=$1

  i3-msg -q workspace "${i3list[WSF]}"

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    [[ $trg =~ A|B ]] && fam=AB || fam=CD 
    i3-msg -q "[con_mark=i34XAC]" unmark
  else
    [[ $trg =~ A|C ]] && fam=AC || fam=BD
    i3-msg -q "[con_mark=i34XAB]" unmark
  fi

  i3gw gurra  > /dev/null 2>&1
  
  i3-msg -q "[con_mark=gurra]" \
    split v, layout tabbed
  
  i3-msg -q "[con_mark=i34${trg}]" \
    move to workspace "${i3list[WSA]}", \
    floating disable, \
    move to mark gurra

  i3-msg -q "[con_mark=gurra]" focus parent
  i3-msg -q mark i34X${fam}, focus parent

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    i3-msg -q "[con_mark=gurra]" layout splith, split h
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34XAC]" layout splitv, split v
  else
    i3-msg -q "[con_mark=gurra]" layout default, split v
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34XAB]" layout splith, split h
  fi

}

containercreate(){

  local trg=$1

  # error can't create container without window
  [[ -z ${i3list[TWC]} ]] && exit 1

  i3gw gurra  > /dev/null 2>&1
  i3-msg -q "[con_mark=gurra]" \
    split h, layout tabbed
  i3-msg -q "[con_id=${i3list[TWC]}]" \
    floating disable, move to mark gurra
  i3-msg -q "[con_mark=gurra]" \
    focus, focus parent
  i3-msg -q mark "i34${trg}"
  i3-msg -q "[con_mark=gurra]" kill
    
  # after creation, move cont to scratch
  i3-msg -q "[con_mark=i34${trg}]" focus, floating enable, \
    move absolute position 0 px 0 px, \
    resize set $((i3list[WFW]/2)) px $((i3list[WFH]/2)) px, \
    move scratchpad
  # add to trg to hid
  i3list[LHI]+=$trg
  # run container show to show container
  containershow "$trg"
}

familycreate(){
  local trg tfam ofam
  trg=$1

  if [[ $trg =~ A|C ]];then
    tfam=AC
    ofam=BD
  else
    ofam=AC
    tfam=BD
  fi

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    if [[ $trg =~ A|B ]];then
      tfam=AB
      ofam=CD
    else
      ofam=AB
      tfam=CD
    fi
  fi

  i3-msg -q "[con_mark=i34X${tfam}]" unmark
  i3gw gurra  > /dev/null 2>&1
  i3-msg -q "[con_mark=gurra]" \
    move to mark "i34X${ofam}", split v, layout tabbed

  i3-msg -q "[con_mark=i34${trg}]" \
    move to workspace "${i3list[WSA]}", \
    floating disable, \
    move to mark gurra
  i3-msg -q "[con_mark=gurra]" focus, focus parent
  i3-msg -q mark i34X${tfam}

  if [[ ${I3FYRA_ORIENTATION,,} = vertical ]]; then
    i3-msg -q "[con_mark=gurra]" layout splith, split h
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34X${tfam}]" move down
  else
    i3-msg -q "[con_mark=gurra]" layout splitv, split v
    i3-msg -q "[con_mark=gurra]" kill
    i3-msg -q "[con_mark=i34X${tfam}]" move right
  fi

}
