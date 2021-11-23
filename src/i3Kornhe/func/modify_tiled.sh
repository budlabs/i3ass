#!/bin/sh

modify_tiled() {

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}()"

  if [[ $_next_mode = m ]]; then

    case "$_direction" in
      l ) _direction=left  ;;
      r ) _direction=right ;;
      u ) _direction=up    ;;
      d ) _direction=down  ;;
    esac

    messy "move $_direction"
    echo EXIT >> "$I3_KORNHE_FIFO_FILE" &

  elif [[ $_next_mode = s ]]; then

    case "$_direction" in
      l ) messy "resize shrink width $_speed px" ;;
      r ) messy "resize grow width $_speed px" ;;
      u ) messy "resize grow height $_speed px" ;;
      d ) messy "resize shrink height $_speed px" ;;
    esac

  fi

}
