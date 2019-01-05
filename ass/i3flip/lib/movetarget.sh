#!/usr/bin/env bash

movetarget(){
  # print id of window left of the one we want to move to.
  # if no warp is needed just print left|right
  local trg ldir curid trgid bdir

  [[ $__dir = n ]] \
    && trg=$((__acur[position]==__acur[total]
              ? 1
              : 0
            )) \
    || trg=$((__acur[position]==1
              ? __acur[total]
              : 0
            ))

  aord=(${__acur[order]:-})
  trgid="${aord[$((trg-1))]}"
  curid="${__acur[focused]}"

  if [[ ${__acur[layout]:-} =~ splith|stacked ]]; then
    case "$__dir" in
      n) ldir=down ;;
      p) ldir=up   ;;
    esac
    bdir=up
  else
    case "$__dir" in
      n) ldir=right ;;
      p) ldir=left   ;;
    esac
    bdir=left
  fi

  if ((trg==0)); then
    i3-msg -q "[con_id=$curid]" move "$ldir"
  else

    if ((trg==1)); then
      i3-msg -q "[con_id=$trgid]" mark fliptmp
      i3-msg -q "[con_id=$curid]" \
        move to mark fliptmp, \
        move "$bdir", \
        focus
      i3-msg -q "[con_id=$trgid]" unmark
    else
      i3-msg -q "[con_id=$trgid]" mark fliptmp
      i3-msg -q "[con_id=$curid]" move to mark fliptmp, focus
      i3-msg -q "[con_id=$trgid]" unmark
    fi
  fi
}
