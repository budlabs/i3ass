#!/usr/bin/env bash

gettarget(){
  local trg

  [[ $__dir = n ]] \
    && trg=$((__acur[position]==__acur[total]
              ? 1
              : __acur[position]+1
            )) \
    || trg=$((__acur[position]==1
              ? __acur[total]
              : __acur[position]-1
            ))

  aord=(${__acur[order]:-})
  echo "${aord[$((trg-1))]}"
}
