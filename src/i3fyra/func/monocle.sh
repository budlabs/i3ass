#!/bin/bash

# https://github.com/budlabs/i3ass/issues/225
monocle_toggle() {

  ((i3list[WSA] == i3list[WSF])) || {
    ERM "mono operation only possible on i3fyra workspace"
    messy fullscreen toggle
    return
  }

  # AWF == 1, active window is floating
  if ((i3list[AWF]==1)); then

    if [[ ${i3list[LVI]} =~ $I3FYRA_MAIN_CONTAINER ]]; then
      target=$I3FYRA_MAIN_CONTAINER
    elif [[ ${i3list[LVI]} ]]; then
      target=${i3list[LVI]:0:1}
    elif [[ ${i3list[LHI]} ]]; then
      target=${i3list[LHI]:0:1}
    else
      target=$I3FYRA_MAIN_CONTAINER
    fi

    if [[ ${i3list[LEX]} =~ $target ]]; then
      container_show "$target"
      messy "[con_id=${i3list[AWC]}]" floating disable, \
        move to mark "i34${target}"
    else
      # if $target container doesn't exist, create it
      container_show "$target"
    fi

    to_hide="${i3list[LVI]/$target/}"
    [[ $to_hide ]] && multi_hide "$to_hide"

  elif ((${#i3list[LVI]} < 2)); then
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
