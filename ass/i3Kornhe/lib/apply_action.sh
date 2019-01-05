#!/usr/bin/env bash

apply_action(){
  local curmo action floatsize

  curmo="$1"
  action=resize

  case "$curmo" in
    topleft )
      case "$__dir" in
        u ) floatsize="grow up"      ;;
        d ) floatsize="shrink up"    ;;
        l ) floatsize="grow left"    ;;
        r ) floatsize="shrink left"  ;;
      esac
    ;;

    topright )
      case "$__dir" in
        u ) floatsize="grow up"      ;;
        d ) floatsize="shrink up"    ;;
        l ) floatsize="shrink right" ;;
        r ) floatsize="grow right"   ;;
      esac
    ;;

    bottomleft )
      case "$__dir" in
        u ) floatsize="shrink down"   ;;
        d ) floatsize="grow down"     ;;
        l ) floatsize="grow left"     ;;
        r ) floatsize="shrink left"   ;;
      esac
    ;;

    bottomright )
      case "$__dir" in
        u ) floatsize="shrink down"   ;;
        d ) floatsize="grow down"     ;;
        l ) floatsize="shrink right"  ;;
        r ) floatsize="grow right"    ;;
      esac
    ;;

    move )

      case "$__dir" in
        u ) floatsize="up"       ;;
        d ) floatsize="down"     ;;
        l ) floatsize="left"     ;;
        r ) floatsize="right"    ;;
      esac

      action=move
      __title=MOVE
    ;;

  esac

  i3-msg -q $action ${floatsize} "${__speed}"
  set_tf
}
