#!/bin/bash

move_to_zen_container() {
  messy "[con_id=${i3list[AWC]}]"     \
        move --no-auto-back-and-forth to workspace "$(next_vacant_workspace)", \
        "floating disable,"           \
        "move to mark $_mark,"        \
        "focus, workspace --no-auto-back-and-forth $_ws_zen"

  [[ $_var_zen_current ]] || i3var set "zen${i3list[AWC]}" "$_var_zen_new"
}
