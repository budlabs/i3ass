#!/bin/bash

NAME="install.sh"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2017-12-06"
UPDATED="2018-06-30"

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
QUIET=0

main(){
  while getopts :vhq: option; do
    case "${option}" in
      q) QUIET=1; TARGET_DIRECTORY="${OPTARG}" ;;
      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;
      h) printinfo && exit ;;
      *) printinfo && ERX "Not a valid command: $0 $@" ;;
    esac
  done

  [[ ${THIS_DIR##*/} != i3ass ]] \
    && ERX "install.sh is not in i3ass folder"

  ((QUIET==1)) \
    && link_scripts "$TARGET_DIRECTORY" \
    || interactive_installer
  
}

interactive_installer(){
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

  OPTIONS=(
    "Installation of scripts and man pages."
    "Install man pages only."
    "Link scripts to a directory."
    "Uninstall."
    "Cancel"
  )

  echo "What do you want to install?"

  echo

  for ((i==0;i<${#OPTIONS[@]};i++)); do
    echo "$((i+1)). ${OPTIONS[$i]}"; done
  
  echo

  read -rsn1 -p \
    "Enter a number 1-${#OPTIONS[@]} (default:${#OPTIONS[@]}) " INT_SELECT

  echo
  echo

  INT_SELECT=${INT_SELECT:-${#OPTIONS[@]}}

  { ((INT_SELECT < 1)) || ((INT_SELECT > ${#OPTIONS[@]})) ;} \
    && ERX "$INT_SELECT is not a valid selection."

  echo
  case $INT_SELECT in
    1|2 ) # Installation of scripts and man pages.
      echo "Specify prefix directory."
      echo "Example: /usr/local"
      echo "Default (leave blank): /usr"
      read -rp 'Directory: ' TARGET_DIRECTORY
      TARGET_DIRECTORY=${TARGET_DIRECTORY:-'/usr'}

      ((INT_SELECT = 1)) && toinstall="install"
      ((INT_SELECT = 2)) && toinstall="install-doc"

      echo
      sudo make PREFIX="${TARGET_DIRECTORY/~/$HOME}" "$toinstall"
      echo
    ;;

    3 ) # Link scripts to a directory.
      echo "Specify directory where you want to link the scripts."
      echo "Example: ~/bin/i3ass"

      read -rp 'Directory: ' TARGET_DIRECTORY

      TARGET_DIRECTORY="${TARGET_DIRECTORY/'~'/$HOME}"
      [[ ${TARGET_DIRECTORY:0:1} != '/' ]] \
        && TARGET_DIRECTORY="$PWD/$TARGET_DIRECTORY"

      echo
      echo "Target directory: $TARGET_DIRECTORY"
      read -p "Continue installation? " -n 1 -r
      echo
      echo
      [[ $REPLY =~ ^[Yy]$ ]] && {
        link_scripts "${TARGET_DIRECTORY}"
        printf '%s\n' \
          " " \
          "Linking complete!" \
          "Make sure that ${TARGET_DIRECTORY} is in the" \
          "PATH environment variable." \
          " "
      } || ERX "NO approval, NO installation."
    ;;

    4 ) # Uninstall.
      sudo make uninstall
      echo "i3ass is unistalled from the system."
      exit
    ;;

    5 ) clear && exit ;;
  esac

  printf '%s\n' \
    "Thank you for installing i3ass. All commands" \
    "can be launched with the -h flag to display" \
    "help about the command. Example:" \
    "$ i3get -h" \
    " " \
    "Happy tiling!"
}

link_scripts() {
  TARGET_DIRECTORY="$1"
  TARGET_DIRECTORY="${TARGET_DIRECTORY/'~'/$HOME}"

  [[ -z "$TARGET_DIRECTORY" ]] \
    && ERX "NO directory, NO installation."

  if [[ ! -d "$TARGET_DIRECTORY" ]]; then
    [[ -e "$TARGET_DIRECTORY" ]] \
      && ERX "[$TARGET_DIRECTORY] exists, but is not a dir"
    mkdir -p "$TARGET_DIRECTORY" \
      || ERX "mkdir [$TARGET_DIRECTORY] failed"
  fi

  for s in ${THIS_DIR}/*; do
    [[ ! -d $s ]] && continue
    FIL_NMN="${s##*/}"
    FIL_SRC="$s/$FIL_NMN"
    [[ ! -f "$FIL_SRC" ]] && continue
    FIL_TRG="${TARGET_DIRECTORY}/$FIL_NMN"
    ln -s "$FIL_SRC" "$FIL_TRG"
    chmod +x "$FIL_TRG"
    ((QUIET!=1)) && echo "Link created: $FIL_TRG"
  done
}

printinfo(){
about='
`install.sh` - i3ass - installation script

SYNOPSIS
--------

`install.sh` [`-v`|`-h`] 
`i3var` [`-q`] [*TARGET_DIRECTORY*]

DESCRIPTION
-----------

This script prompts you for a *TARGET_DIRECTORY*, if it isn'"'"'t
given as an argument. When the *TARGET_DIRECTORY* is known,
*TARGET_DIRECTORY* will be created if it doesn'"'"'t exist and
all scripts in the i3ass suite will be symlinked
to *TARGET_DIRECTORY* and made executable.

OPTIONS
-------

`-v`  
  Show version and exit.  

`-h`  
  Show help and exit.  

`q`  
  quiet mode, show no output. *TARGET_DIRECTORY* must be set.

DEPENDENCIES
------------

- i3ass
'
bouthead="
${NAME^^} 1 ${CREATED} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${AUTHOR} <${CONTACT}>
<https://budrich.github.io>

SEE ALSO
--------

i3gw(1)
"

  case "$1" in
    m ) printf '%s' "${about}" ;;
    
    f ) 
      printf '%s' "${bouthead}"
      printf '%s' "${about}"
      printf '%s' "${boutfoot}"
    ;;

    ''|* ) 
      printf '%s' "${about}" | awk '
         BEGIN{ind=0}
         $0~/^```/{
           if(ind!="1"){ind="1"}
           else{ind="0"}
           print ""
         }
         $0!~/^```/{
           gsub("[`*]","",$0)
           if(ind=="1"){$0="   " $0}
           print $0
         }
       '
    ;;
  esac
}

ERR(){ >&2 echo "[WARNING]" $@ ; }
ERX(){ >&2 echo "[ERROR]" $@ && exit 1 ; }

if [ "$1" = "md" ]; then
  printinfo m
  exit
elif [ "$1" = "man" ]; then
  printinfo f
  exit
else
  main "${@}"
fi
