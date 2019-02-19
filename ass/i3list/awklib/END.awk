END {

  # mirror active to target if no criteria is given

  if (crit == "X") {
    for (k in window["A"]) {
      tk=k;sub("A","T",tk)
      if (!window["T"][tk]) {window["T"][tk]=window["A"][k]}
    }

    if (!workspace["WST"]) {setworkspace(workspace["WAI"],"T")}  
  }
  
  stringformat="i3list[%s]=%-15s\t# %s\n"
  descriptions()

  if (toprint ~ /^(all|active|window)$/) {
    for (k in window["A"]){
      printf(stringformat, k, window["A"][k], desc[k])
    }
  }

  
  if (toprint ~ /^(all|target|window)$/) {

    if (window["T"]["TWC"]) {
      for (k in window["T"]) {
        printf(stringformat, k, window["T"][k], desc[k])
      }
    }
  }


  # following block will only get printed if there is 
  # an i3fyra layout.

  if (workspace["WSF"]) {

    if (toprint ~ /^(all|container|i3fyra)$/) {
      for (k in container) {
        printf(stringformat, k, container[k], desc[k])
      }
    }

    for (k in defaults) {

      if (container["C" defaults[k] "W"]){
        if (container["C" defaults[k] "W"] == workspace["WSF"]){
          layout["LVI"]=defaults[k] layout["LVI"]
        } else {
          layout["LHI"]=defaults[k] layout["LHI"]
        }
      }

    }

    if (ENVIRON["I3FYRA_ORIENTATION"]=="vertical") {
    splits[1]="AB"
    splits[2]="CD"
    splits[3]="AC"
  }


    layout["LEX"]=layout["LVI"] layout["LHI"]

    if (ENVIRON["I3FYRA_ORIENTATION"]=="vertical") {
      # ac and bd is the same, height of a or b
      if (layout["LVI"] ~ "A") {
        outsplit["SAC"]=dim[acon["A"]]["window"]["height"]
      }
      else if (layout["LVI"] ~ "B") {
        outsplit["SAC"]=dim[acon["B"]]["window"]["height"]
      }
      else {
        outsplit["SAC"]=0
      }
      
      outsplit["SBD"]=outsplit["SAC"]
      outsplit["SAB"]=dim[acon["A"]]["window"]["width"]
      outsplit["SCD"]=dim[acon["C"]]["window"]["width"]
    } else {
      # ab and cd is the same, width of a or c
      if (layout["LVI"] ~ "A") {
        outsplit["SAB"]=dim[acon["A"]]["window"]["width"]
      }
      else if (layout["LVI"] ~ "C") {
        outsplit["SAB"]=dim[acon["C"]]["window"]["width"]
      }
      else {
        outsplit["SAB"]=0
      }

      outsplit["SCD"]=outsplit["SAB"]
      outsplit["SAC"]=dim[acon["A"]]["window"]["height"]
      outsplit["SBD"]=dim[acon["B"]]["window"]["height"]
    }

    if (layout["LVI"] ~ "[" splits[1] "]") {
      if (layout["LVI"] !~ "[" splits[2] "]") {outsplit["S"splits[3]]=0}
      if (layout["LHI"] ~ "[" splits[1] "]") {outsplit["S"splits[1]]=0}
    }

    if (layout["LVI"] ~ "[" splits[2] "]") {
      if (layout["LVI"] !~ "[" splits[1] "]") {outsplit["S"splits[3]]=0}
      if (layout["LHI"] ~ "[" splits[2] "]") {outsplit["S"splits[2]]=0}
    }
    
    if (toprint ~ /^(all|splits|i3fyra)$/) {
      for(k in outsplit){
        printf(stringformat, k, outsplit[k], desc[k])
      }
    }


    if (toprint ~ /^(all|layout|i3fyra)$/) {
      for(k in layout){
        printf(stringformat, k, layout[k], desc[k])
      }

      for(k in family){
        printf(stringformat, k, family[k], desc[k])
      }
    }
  }

  layout["LAL"]=splits[1] splits[2]
  printf(stringformat, "LAL", layout["LAL"], desc["LAL"])
  if (toprint ~ /^(all|workspace)$/) {
    for(k in workspace){
      printf(stringformat, k, workspace[k], desc[k])
    }
  }
}
