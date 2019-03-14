#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3ass - version: 2019.03.14.5
updated: 2019-03-14 by budRich
EOB
}



set -o errexit
set -o pipefail
set -o nounset

main(){
  ___printversion
  echo
  whosinstalled $(asslist)
  echo
  echo 'dependencies:'
  checkdeps $(deplist)
}

___printhelp(){
  
cat << 'EOB' >&2
i3ass - i3 assistance scripts


OPTIONS
-------
EOB
}


asslist() {
cat << 'EOB'
i3flip
i3fyra
i3get
i3gw
i3Kornhe
i3list
i3menu
i3run
i3var
i3viswiz
EOB
}

checkdeps(){
  local status
  local longest_dep_name=0

  for d in "${@}"; do
    ((${#d}>longest_dep_name)) \
      && longest_dep_name=${#d}
  done

  : $((longest_dep_name+=1))

  for d in "${@}"; do
    command -v "$d" > /dev/null 2>&1 \
      && status="[INSTALLED]" \
      || status="[NOT FOUND]"

    printf '%-'${longest_dep_name:-15}'s %s\n' \
      "$d" "$status"
  done
}

deplist() {
cat << 'EOB'
bash
gawk
i3
rofi
sed
xdotool
EOB
}

ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

whosinstalled(){
  local longest_dep_name=0

  for d in "${@}"; do
    ((${#d}>longest_dep_name)) \
      && longest_dep_name=${#d}
  done

  header="$(printf '%-'${longest_dep_name:-15}'s | %s\n' \
        "script" "version")"
  echo "$header"
  echo "$header" | sed 's/./-/g'

  for d in "${@}"; do
    if [[ $(command -v "$d") ]]; then
      verre=$("$d" -v 2>&1 | awk '{print $NF;exit}')
      printf '%-'${longest_dep_name:-15}'s | %s\n' \
        "$d" "$verre"
    else
      printf '%-'${longest_dep_name:-15}'s version: %s\n' \
        "$d" "[NOT FOUND]"
    fi
  done
}
declare -A __o
eval set -- "$(getopt --name "i3ass" \
  --options "" \
  --longoptions "" \
  -- "$@"
)"

while true; do
  case "$1" in
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

if [[ ${__o[help]:-} = 1 ]]; then
  ___printhelp
  exit
elif [[ ${__o[version]:-} = 1 ]]; then
  ___printversion
  exit
fi

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" 


main "${@:-}"


