#!/usr/bin/env bash

getcurrent(){
  i3-msg -t get_tree \
  | awk -v RS=',' -F':' -v crit='"focused"' -v srch="true" '
      BEGIN{fid="0";nid="0";nfo="0";nwi}

      $1~"{\"id\"" || $2~"\"id\"" {
        nwi=nwi+1;cid=$NF;aid[nwi]=cid}
      $1 ~ crit && $2 ~ srch  {fid=cid}
      $2 ~ crit && $3 ~ srch  {fid=cid}

      $1=="\"layout\"" {alo[cid]=$2}

      fid!="0" && $1=="\"focus\"" && $2~fid {focs=1}
      focs=="1" && $NF~"[]]$"{end=1}
      focs=="1" {gsub("[]]|[[]","",$NF);afo=$NF"|"afo;nfo++}
      end=="1" {
        j=nfo

        for (i=nwi;i>0;i--){
          if(fin==1){plo=alo[aid[i]];parid=aid[i];break}
          if(aid[i]==fid){n=j}
          if(afo ~ aid[i]){ord=aid[i]" "ord;--j}
          
          if(j==0){fin=1}
        }
        gsub("[\"]","",plo)

        print "__acur[position]=" n
        print "__acur[total]="    nfo
        print "__acur[layout]="   plo
        sub(/[[:space:]]*$/,"",ord)
        print "__acur[order]=\""  ord "\""
        print "__acur[parent]="   parid
        print "__acur[focused]="  fid

        exit
      } 
    '
}
