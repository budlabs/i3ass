BEGIN {hit=0;start=0;trg=0}

# set crit array
start == 0 {
  if ($0 == "__START__") {
    start = 1
  } else if (/./) {
    crit[$1]=$2
    trg++
  }
}

start == 1 && match($0,/([{]|"nodes":[}][[]|.*_rect":{)?"([a-z_]+)":[["]*([^]}"]*)[]}"]*$/,ma) {

  key=ma[2]
  var=ma[3]

  if (hit!=trg) {
    for (c in crit) {
      # if (key == c) {print crit[c] "  s " var}
      if (key == c && var ~ crit[c]) {
        if (fid==cid) {hit++}
        else {hit=1;fid=cid}
      }
    }
  }


  # on every id, check if target is found, if so exit
  # otherwise clear return array (except workspace key)
  if (key == "id") {
    if (hit == trg) exit
    cid=var
    hit=0
    for(k in r){if(k!="w"){r[k]=""}}
    if(sret ~ /[n]/)
      r["n"]=cid
  }

  if (sret ~ /[t]/ && key == "title") {
    r["t"]=gensub($1":","",1,$0)
  }
  
  if (sret ~ /[c]/ && key == "class") {
    r["c"]=var
  }
  
  if (sret ~ /[i]/ && key == "instance") {
    r["i"]=var
  }
  
  if (sret ~ /[d]/ && key == "window") {
    r["d"]=var
  }
  
  if (sret ~ /[m]/ && key == "marks") {
    r["m"]=var
  }
  
  if (sret ~ /[a]/ && key == "focused") {
    r["a"]=var
  }
  
  if (sret ~ /[o]/ && key == "title_format") {
    r["o"]=var
  }
  
  if (sret ~ /[w]/ && key == "num") {
    r["w"]=var
  }
  
  if (sret ~ /[f]/ && key == "floating") {
    r["f"]=var
  }

}

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
