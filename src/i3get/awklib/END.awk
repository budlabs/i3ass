END {

  if ( !arg_target ) {
    target_container_id=active_container_id
  } else {

    for (suspect_id in suspect_targets) {

      search_match=0

      for (search in arg_search) { 
        if (match(ac[suspect_id][search],arg_search[search]))
          search_match+=1
      }

      if (search_match == length(arg_search)) {
        target_container_id=suspect_id
        break
      }
    }
  }

  if (! target_container_id)
    exit

  split(arg_print,toprint,"")

  for (k in toprint) {
    switch(toprint[k]) {

      case "t":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["name"])
      break

      case "c":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["class"])
      break

      case "i":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["instance"])
      break

      case "d":
        print ac[target_container_id]["window"]
      break

      case "n":
        print target_container_id
      break

      case "m":
        print ac[target_container_id]["marks"]
      break

      case "w":
        target_workspace_id = ac[target_container_id]["workspace"]
        print ac[target_workspace_id]["num"]
      break

      case "a":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["focused"])
      break

      case "f":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["floating-i3get"])
      break

      case "o":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["title_format"])
      break

      case "e":
        print ac[target_container_id]["fullscreen_mode"]
      break

      case "s":
        print ac[target_container_id]["sticky"]
      break

      case "u":
        print ac[target_container_id]["urgent"]
      break

      case "y":
        print gensub(/^"|"$/,"","g",ac[target_container_id]["window_type"])
      break

      case "r":
        if ("window_role" in ac[target_container_id])
          print gensub(/^"|"$/,"","g",ac[target_container_id]["window_role"])
        else
          print "unknown"
      break
    }
  }
}
