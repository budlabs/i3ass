#!/bin/bash

apply_rules() {
  declare -a ids
  declare -a wininfo
  mapfile -t ids <<< "$(all_window_ids)"

  # cid=$1 class=$2 instance=$3 title=$4 type=$5
  for id in "${ids[@]}"; do
    mapfile -t wininfo <<< "$(i3get -d "$id" -r ncityd)"
    sleep .1
    match_window "${wininfo[@]}" apply
  done
}

all_window_ids() {
  i3-msg -t get_tree \
    | gawk '$1 == "\"window\"" && $2 != "null" {print $2}' RS=, FS=:
}
