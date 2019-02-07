#!/usr/bin/env bash

themefile(){
  local themebase themefile themevars usrtheme

  usrtheme=${__o[theme]:-default}
  usrtheme="${usrtheme%.rasi}"

  themefile="${I3MENU_DIR}/themes/$usrtheme.rasi"
  themebase="${I3MENU_DIR}/base/i3menu.rasi"
  themevars="${I3MENU_DIR}/base/themevars.rasi"

  if [[ ! -f $themebase ]] || [[ ! -f $themevars ]]; then
    createconf "${I3MENU_DIR}"
  fi

  [[ -f $themefile ]] || {
    [[ -d ${I3MENU_DIR} ]] || createconf "${I3MENU_DIR}"
    themefile="${I3MENU_DIR}/themes/default.rasi"
  }

  echo "${__themelayout:-}"
  cat "$themevars" "$themefile" "$themebase"
}
