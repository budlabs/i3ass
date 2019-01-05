#!/usr/bin/env bash

getwindow(){
  {
    for c in "${!__crit[@]}"; do
      echo -n "$c:${__crit[$c]},"
    done

    echo -n "__START__,"

    i3-msg -t get_tree
  } | awk -v RS=',' -F':' -v sret="${__o[print]:-n}" '
    BEGIN {hit=0;start=0;trg=0}

      # set crit array
      start==0 && $0 !~ "__START__" && /./ {
        crit[$1]=$2
        trg++
      }

      # reset return array
      $(NF-1) ~ /"id"$/ {
        if (hit == trg) exit
        cid=$NF
        hit=0
        for(k in r){if(k!="w"){r[k]=""}}
        if(sret ~ n)
          r["n"]=cid
        
      }

      start==1 && hit!=trg {
        for (c in crit) {
          if ($(NF-1) ~ "\"" c "\"" && $NF ~ crit[c]) {
            if (fid==cid) {hit++}
            else {hit=1;fid=cid}
          }
        }
      }


      sret ~ "t" && $1=="\"title\"" {sub($1":","");r["t"]=$0}
      sret ~ "c" && $(NF-1) ~ "\"class\"" {r["c"]=$NF}
      sret ~ "i" && $1=="\"instance\"" {r["i"]=$2}
      sret ~ "d" && $1=="\"window\"" {r["d"]=$2}
      sret ~ "m" && $1=="\"marks\"" {r["m"]=$2}
      sret ~ "a" && $1=="\"focused\"" {r["a"]=$2}
      sret ~ "o" && $1=="\"title_format\"" {r["o"]=$2}
      sret ~ "w" && $1=="\"num\"" {r["w"]=$2}
      sret ~ "f" && $1=="\"floating\"" {r["f"]=$2}
      
      /__START__/ {start=1}

    END{
      if (hit==0) exit
      split(sret, aret, "")
      for (i=1; i <= length(sret); i++) {
        op=r[aret[i]]
        gsub(/^["]|["]$/,"",op)
        if(op!="")
          printf("%s\n", op)
      }
    }
    '
}
