#!/bin/bash

NAME="install.sh"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2017-12-06"
UPDATED="2017-12-06"

about="
$NAME - $VERSION - $UPDATED
created: $CREATED by $AUTHOR
*******************************
i3ass - installation script
---------------------------
This script prompts you for a FOLDER, if it isn't
given as an argument. When the FOLDER is known,
FOLDER will be created if it doesn't exist and
all scripts in the i3ass suite will be symlinked
to FOLDER and made executable.

usage
-----
\`\$ $NAME [OPTION] [PATH]\`

| option | argument | function                   |
|:-------|:---------|:---------------------------|
| -q     |          | quiet mode, show no output |
|        |          | PATH must be set           |
| -v     |          | show version info and exit |
| -h     |          | show this help and exit    |

dependencies
------------
- i3ass

contact
-------
$CONTACT
"

FLD_THIS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
QUIET=false

# create symlinks for all helper scripts
function link_scripts {
  FLD_TRG="$1"
  FLD_TRG="${FLD_TRG/'~'/$HOME}"
  [[ -z "$FLD_TRG" ]] \
    && echo \
    && echo "NO folder, NO installation." && exit 1

  [[ ! -d "$FLD_TRG" ]] && mkdir -p "$FLD_TRG"

  for s in ${FLD_THIS}/*; do
    [[ ! -d $s ]] && continue
    FIL_TRG="$s/${s##*/}"
    [[ ! -f "$FIL_TRG" ]] && continue
    ln -s "$FIL_TRG" "${FLD_TRG}/${s##*/}"
    chmod +x "${FLD_TRG}/${s##*/}"
    [ ! $QUIET ] && echo "Link created: ${FLD_TRG}/${s##*/}"
  done
}


while getopts :vhq option
do
  case "${option}" in
    v) printf '%s\n' \
         "$NAME - version: $VERSION" \
         "updated: $UPDATED by $AUTHOR"
       exit ;;
    h) printf '%s\n' "${about}" && exit ;;
    q) QUIET=true; link_scripts "${2}" && exit ;;
  esac
done


[[ ${FLD_THIS##*/} != i3ass ]] \
  && echo "install.sh is not in i3ass folder" && exit 1

clear

echo

printf '%s\n' \
" ██  ████                           " \
"░░  █░░░ █                          " \
" ██░    ░█  ██████    ██████  ██████" \
"░██   ███  ░░░░░░██  ██░░░░  ██░░░░ " \
"░██  ░░░ █  ███████ ░░█████ ░░█████ " \
"░██ █   ░█ ██░░░░██  ░░░░░██ ░░░░░██" \
"░██░ ████ ░░████████ ██████  ██████ " \
"░░  ░░░░   ░░░░░░░░ ░░░░░░  ░░░░░░  " \
" ------- installation script ------ "

echo

FLD_TRG="$1"
if [[ -z "$FLD_TRG" ]]; then
  echo "example folder: (~/i3ass)"
  read -rp 'Specify target folder: ' FLD_TRG
  FLD_TRG="${FLD_TRG/'~'/$HOME}"
  [[ -z "$FLD_TRG" ]] \
    && echo \
    && echo "NO folder, NO installation." && exit 1
fi

[[ ${FLD_TRG:0:1} != '/' ]] && FLD_TRG="$(pwd)/$FLD_TRG"

echo
echo "Target folder: $FLD_TRG"
read -p "Continue installation? " -n 1 -r
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  link_scripts ${FLD_TRG}
  echo
  printf '%s\n' \
  "Thank you for installing i3ass. All commands" \
  "can be launched with the -h flag to display" \
  "help about the command. Example:" \
  "i3get -h" \
  " " \
  "be sure that ${FLD_TRG} is in the" \
  "PATH environment variable." \
  " " \
  "Happy tiling!"
else
  echo "NO approval, NO installation." && exit 1
fi
