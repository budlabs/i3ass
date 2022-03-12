#!/bin/bash

swap_move(){

  ((_o[verbose])) && ERM "f ${FUNCNAME[0]}($*)"

  local m1=$1 m2=$2
  local c1 c2 i1 i2 v1 v2 tmrk k
  declare -i tspl tdim

  messy "[con_mark=${m1}]"  swap mark "${m2}", mark i34tmp
  messy "[con_mark=${m2}]"  mark "${m1}"
  messy "[con_mark=i34tmp]" mark "${m2}"

  # ck_ -> character key
  # ik_ -> integer key
  declare -A ck_default
  declare -A ck_target
  declare -a ik_current

  ck_default=([A]=0 [B]=1 [C]=2 [D]=3)
  
  # if: i3list[VPA]=2 ; i3list[VPC]=0 \
  #       -> ik_current=([0]=C [1]=B [2]=A [3]=D)
  for k in A B C D; do
    current_val=${i3list[VP${k}]:=${ck_default[$k]}}
    ik_current[${current_val}]=$k
  done

   ERM "${ik_current[*]} LLLLLLLL"

  # family marks always contain 'X'
  # when we swap families all virtual positions
  # are swapped
  if [[ $m1 =~ X ]]; then

    ((_isvertical)) \
      && ck_target=([A]=C [B]=D [C]=A [D]=B) \
      || ck_target=([A]=B [B]=A [C]=D [D]=C)

    tdim=${ori[sizemain]}
    tmrk=${ori[main]}
    tspl=${i3list[S$tmrk]}

    mark_vars[i34M${ori[fam1]}]=${i3list[M${ori[fam2]}]}
    mark_vars[i34M${ori[fam2]}]=${i3list[M${ori[fam1]}]}

    ERM "VPA=${i3list[VPA]}; VPB=${i3list[VPB]}; VPC=${i3list[VPC]}; VPD=${i3list[VPD]}"
    for k in A B C D; do

      c1=${k}                     c2=${ck_target[$k]}
      i1=${ck_default[$c1]}       i2=${ck_default[$c2]}
      v1=${ik_current[$i1]:=$c1}  v2=${ik_current[$i2]:=$c2}

      mark_vars[i34VP$v1]=$i2
      mark_vars[i34VP$v2]=$i1

      [[ ${i3list[LEX]} =~ $k ]] || continue
      messy "[con_mark=i34$k]" mark "i34tmp$k"
    done

    for k in A B C D; do
      [[ ${i3list[LEX]} =~ $k ]] || continue
      messy "[con_mark=i34tmp$k]" mark "i34${ck_target[$k]}"
    done

    
  else # swap within family

    c1=${m1#i34}                c2=${m2#i34}
    i1=${ck_default[$c1]}       i2=${ck_default[$c2]}
    v1=${ik_current[$i1]:=$c1}  v2=${ik_current[$i2]:=$c2}

    mark_vars[i34VP$v1]=$i2
    mark_vars[i34VP$v2]=$i1

    [[ ${ori[fam1]} =~ $c1 ]] \
      && tmrk=${ori[fam1]} \
      || tmrk=${ori[fam2]}

    tspl="${i3list[S${tmrk}]}"
    tdim=${ori[sizefam]}

  fi

  # invert split
  ((tspl+tdim)) && apply_splits "$tmrk=$((tdim-tspl))"

  messy "[con_id=${i3list[TWC]}]" focus
}
