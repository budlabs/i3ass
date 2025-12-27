#!/bin/bash

# https://github.com/budlabs/i3ass/issues/225
monocle_toggle() {

  ((i3list[WSA] == i3list[WSF])) || {
    ERM "mono operation only possible on i3fyra workspace"
    messy fullscreen toggle
    return
  }

  if ((${#i3list[LVI]} < 2)); then
    # use family memory if it exist
    last_seen="${i3list[F${ori[fam1]}]}${i3list[F${ori[fam2]}]}"
    [[ $last_seen ]] \
      && to_show=$last_seen \
      || to_show=${i3list[LEX]}
    
    multi_show "$to_show"
    messy "[con_id=${i3list[AWC]}]" focus
  else
    multi_hide "${i3list[LVI]/${i3list[AWP]}/}"
  fi
}
