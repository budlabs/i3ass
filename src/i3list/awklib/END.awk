END {
  descriptions()

  # strfrm is the format string used for the output
  strfrm="i3list[%s]=%-26s # %s\n"

  # determine target container ID
  if ( length(arg_search) == 0 ) {
    target_container_id=active_container_id
  } else {

    for (suspect_id in suspect_targets) {

      search_match=0

      for (search in arg_search) { 
        if (match(ac[suspect_id][search],arg_search[search]))
          search_match+=1
      }

      if (search_match == length(arg_search)) {
        SUS++
        if (length(target_container) == 0)
          target_container_id=suspect_id
      }
    }
  }


  # initialize i3fyra values
  if (i3fyra_workspace_id) {
    orientation=("ORI" in fyra_vars ? fyra_vars["ORI"] : "horizontal")
    if (orientation == "horizontal") {
      main_split="AB"
      
      fyra_vars["LAL"]="ACBD"

      # SAB - main split size
      if ("A" in fyra_containers && fyra_containers["A"]["visible"]) {
        main_split_size=ac[fyra_containers["A"]["id"]]["w"]
      }
      else if ("C" in fyra_containers && fyra_containers["C"]["visible"])
        main_split_size=ac[fyra_containers["C"]["id"]]["w"]
      else
        main_split_size=0

      if (main_split_size == ac[i3fyra_workspace_id]["w"])
        main_split_size=0
    }

    else if (orientation == "vertical") {
      main_split="AC"
      
      fyra_vars["LAL"]="ABCD"

      # SAC - main split size
      if ("A" in fyra_containers && fyra_containers["A"]["visible"])
        main_split_size=ac[fyra_containers["A"]["id"]]["h"]
      else if ("B" in fyra_containers && fyra_containers["B"]["visible"])
        main_split_size=ac[fyra_containers["B"]["id"]]["h"]
      else
        main_split_size=0

      if (main_split_size == ac[i3fyra_workspace_id]["h"])
        main_split_size=0
    }
  }

  at["A"]=active_container_id
  at["T"]=target_container_id

  for (target in at) {
    id=at[target]
    if (id) {
      # if its not a con it is probably a workspace
      # dont print window info on that id
      if (ac[id]["type"] == "\"con\"")
      {
        print_window(target,id)
        print ""

        if (i3fyra_workspace_id) {

          parent_id=ac[id]["parent"]
          awp=ac[parent_id]["i3fyra_mark"]
          grand_parent_id=ac[parent_id]["parent"]
          gwp=ac[grand_parent_id]["i3fyra_mark"]

          if (awp) {
            print_fyra_window(target,id,awp)
            print ""
          } else if (gwp) {
            print_fyra_window(target,id,gwp)
            print ""
          }

        }
      }

      if (target == "A" || target_container_id == active_container_id)
        print_workspace(target,active_workspace_id)
      else
        print_workspace(target,ac[id]["workspace"])
      print ""
    }
  }

  ### -- I3FYRA STUFF
  if (i3fyra_workspace_id) {
    print_workspace("F",i3fyra_workspace_id)
    print ""

    for (container_name in fyra_containers) {
      container_id=fyra_containers[container_name]["id"]
      workspace_id=fyra_containers[container_name]["workspace"]

      key="C" container_name "L"; printf(strfrm,key, ac[container_id]["layout"], desc[key])
      key="C" container_name "W"; printf(strfrm,key, ac[workspace_id]["num"], desc[key])
      key="C" container_name "N"; printf(strfrm,key, ac[workspace_id]["name"], desc[key])

      focused=ac[container_id]["focused"]
      # make sure the focused container is a window
      # while (!("window" in ac[focused]))
      #   focused=ac[focused]["focused"]

      key="C" container_name "F"; printf(strfrm,key, focused, desc[key])

      if (fyra_containers[container_name]["visible"])
        LVI=LVI container_name
      else 
        LHI=LHI container_name
    }
    
    key="LVI"; printf(strfrm,key, LVI, desc[key])
    key="LHI"; printf(strfrm,key, LHI, desc[key])
    key="LEX"; printf(strfrm,key, LVI LHI, desc[key])

    for (family in fyra_splits) {

      first=substr(family,1,1)

      split(family,split_childs,"")
      first_id=fyra_containers[first]["id"]

      if (family == main_split)
        family_split_size = main_split_size

      else if ( orientation == "horizontal"       && 
           fyra_containers[first]["visible"] &&
           ac[first_id]["h"] != ac[i3fyra_workspace_id]["h"] )
        family_split_size=ac[first_id]["h"]

      else if ( orientation == "vertical"         && 
                fyra_containers[first]["visible"] &&
                ac[first_id]["w"] != ac[i3fyra_workspace_id]["w"] )
        family_split_size=ac[first_id]["w"]

      else
        family_split_size=0

      key="S" family; printf(strfrm, key, family_split_size, desc[key])
    }
    # key="S" main_split; printf(strfrm, key, main_split_size, desc[key])

    print ""
    for (key in fyra_vars) {
      printf(strfrm, key, fyra_vars[key], desc[key])
    }
    
  }

  print ""
  printf(strfrm, "RID", root_id, desc["RID"])
  printf(strfrm, "SUS", SUS, desc["SUS"])
}
