#!/bin/bash

# --swap sibling|family
swap() {
  declare target=$1 current_container
  declare -A layout
  
  if [[ $target = family && ${i3list[AFO]} =~ [${i3list[LVI]}] ]]
    then swap_move "i34X${ori[fam1]}" "i34X${ori[fam2]}"
  elif [[ $target = sibling && ${i3list[AFS]} =~ [${i3list[LVI]}] ]]
    then swap_move "i34${i3list[AWP]}" "i34${i3list[AFS]}"
  elif [[ $target =~ cycle(CC|CW)? ]]; then

    rotation=${BASH_REMATCH[1]:-CW}

    if [[ ${rotation^^} = CC ]]; then
      layout=(
        [A]=C [B]=A
        [C]=D [D]=B
      )
    else # CW
      layout=(
        [A]=B [B]=D
        [C]=A [D]=C
      )
    fi

    current_container=${i3list[AWP]}

    case "${#i3list[LVI]}" in
      4 ) target_container=${layout[$current_container]} ;;
      2 ) target_container=${i3list[LVI]//$current_container/} ;;
      3 )
        target_container=${layout[$current_container]}

        # cousin (AFC) is always second choice
        [[ ${i3list[LVI]} =~ $target_container ]] \
          || target_container=${i3list[AFC]}
      ;;
      1 ) ERM "we are one, no swapping" ;;
      * ) ERX "broken layout"           ;;
    esac

    if [[ ${i3list[AFF]} =~ $target_container ]]
      then swap sibling
      else swap family
    fi

  fi
}  
