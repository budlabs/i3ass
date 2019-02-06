hit!=0 && $0~"{" {hit++}
hit!=0 && $0~"}" {hit--}

$1 == "\"rect\"" && dimget != "workspace" {dimget="window"}
$1 == "\"deco_rect\"" {dimget="tab"}

match($0,/([{]|"nodes":[}][[]|.*_rect":{)?"([a-z_]+)":[["]*([^]}"]*)[]}"]*$/,ma) {
  key=ma[2]
  var=ma[3]

  if (trg == 0 && key == crit && var ~ srch) {
    if (key=="id") {curcid=var}
    window["T"]["TWC"]=curcid
    trg=1
  }

  switch (key) {
    case "focus":
      if (hit!=0) {
        container["C"curcon"F"]=var
      } else {
        # define active workspace by id
        # (only useful when workspace is empty)
        for (w in aws) {
          if (var == w) {
            setworkspace(w,"A")
          }
        }
      }
    break

    case "window":
      curwid=var
    break

    case "name":
      curnam=var
    break

    case "num":
      aws[curcid]["num"]=curws=var
      aws[curcid]["name"]=curwsnam=curnam
      curwsid=curcid
    break

    case /^(width|height|x|y)$/ :

      if (dimget != 0) {
        dim[curcid][dimget][key]=var
      }

      if (key == "height") {dimget=0}

    break

    case "id":
      curcid=var
      if (hit!=0) {conta[curcon]["id"]=curcid}
    break

    case "floating":
      if (curcid == window["A"]["AWC"] && act != 2) {
        setwindow(var,"A")
        act=2
      }

      if (curcid == window["T"]["TWC"] && trg != 2) {
        setwindow(var,"T")
        trg=2
      }
    break

    case "marks":

      if (var ~ /^i34[ABCD]$/) {
        hit=1
        curcon=substr(var,4,1)
        container["C"curcon"W"]=curws
        container["C"curcon"L"]="-"
        acon[curcon]=curcid
      }

      else if (var ~ /^i34X.*/ && fourspace != 1) {
        # if mainsplit container exist, get i3fyra
        # workspace on next occurrence of "num".

        setworkspace(curwsid,"F")
        fourspace=1
      }

      else if (var ~ /i34M(AB|CD|AC|BD)/) {
        split(var,mrksplt,"=")
        outsplit[substr(var,4,3)]=mrksplt[2]
      }

      else if (var ~ /i34F(AB|CD|AC|BD)/) {
        split(var,mrksplt,"=")
        family[substr(var,4,3)]=mrksplt[2]
      }

    break

    case "layout":
      if (hit!=0 && container["C"curcon"L"]=="-") {
        container["C"curcon"L"]=var
      }
    break

    case "focused":
      if (var == "true") {
        window["A"]["AWC"]=curcid
        act=1
      }
    break

  }
}
